import 'package:bookify/providers/libro_provider.dart';
import 'package:bookify/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../widgets/custom_button.dart';
 
class AddBookScreen extends StatefulWidget {
  const AddBookScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  DateTime initialDate = DateTime.now();
  DateTime endDate = DateTime.now();
  late TextEditingController nombreLibro;
  late TextEditingController authorLibro;
  late TextEditingController generoLibro;
  late TextEditingController linkLibro;

  //TODO: add place picking
  // var placePickerValue = const FFPlace();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  XFile? image;
  final formKey = GlobalKey<FormState>();

  //GRAPHQL
  final client = PocketBase('https://deitacapp.cbluna-dev.com/');

  @override
  void initState() {
    super.initState();
    nombreLibro = TextEditingController();
    authorLibro = TextEditingController();
    generoLibro = TextEditingController();
    linkLibro = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
   final LibroProvider libroProvider =
        Provider.of<LibroProvider>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Transform.scale(
          scale: .7,
          child: InkWell(
            
            child: Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 20,
            ),
            onTap: () async {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Agregar libro',
          style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          String? option = await showModalBottomSheet(
                            context: context,
                            builder: (_) => const CustomBottomSheet(),
                          );

                          if (option == null) return;

                          final picker = ImagePicker();

                          late final XFile? pickedFile;

                          if (option == 'camera') {
                            pickedFile = await picker.pickImage(
                              source: ImageSource.camera,
                              maxHeight: 1080,
                              maxWidth: 1920,
                              imageQuality: 100,
                            );
                          } else {
                            pickedFile = await picker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 100,
                            );
                          }

                          if (pickedFile == null) {
                            return;
                          }

                          setState(() {
                            image = pickedFile;
                          });
                        },
                        child: Material(
                          elevation: 3,
                          color: Colors.transparent,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.purple,
                                width: 2,
                              ),
                            ),
                            child: getImage(image?.path),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //NOMBRE
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            elevation: 3,
                            child: TextFormField(
                              controller: nombreLibro,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El nombre es requerido';
                                }
                                return null;
                              },
                              decoration: _getInputDecoration(
                                context,
                                'kqq9v312',
                                'pdmyckm7',
                              ),
                              style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),

                        //FECHAS
                        //TODO: verificar que fecha inicial < fecha final
                     

                        //DESCRIPCION
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Material(
                            elevation: 3,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: TextFormField(
                              controller: authorLibro,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El author es requerido' /* Descripcion es requerida */;
                                  
                                }
                                return null;
                              },
                              decoration: _getInputDecoration(
                                context,
                                '367ui4t2',
                                'pcxf1o3c',
                              ),
                              style:TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              maxLines: 3,
                            ),
                          ),
                        ),

                        //DIRECCION
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            elevation: 3,
                            child: TextFormField(
                              controller: linkLibro,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 
                                    'El link es requerido' /* Direccion es requerida */;
                                  
                                }
                                return null;
                              },
                              decoration: _getInputDecoration(
                                context,
                                '787hg4t2',
                                '787hg4t2',
                              ),
                              style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            
                          ),
                        ),
                      
                      Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            elevation: 3,
                            child: TextFormField(
                              controller: generoLibro,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 
                                    'El genero es requerido' /* Direccion es requerida */;
                                  
                                }
                                return null;
                              },
                              decoration: _getInputDecoration(
                                context,
                                '787hg4t2',
                                '787hg4t2',
                              ),
                              style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            
                          ),
                        ),
                      
                        //BOTON AGREGAR EVENTO
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              onPressed: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                //Upload image
                                if (image != null) {
                                  var byteData = await image!.readAsBytes();

                                  var multipartFile = MultipartFile.fromBytes(
                                    'img',
                                    byteData,
                                    filename:
                                        '${DateTime.now().millisecondsSinceEpoch}.jpg',
                                    contentType: MediaType("image", "jpg"),
                                  );
                                  try {
                                    final record = await 
                                        client.records
                                        .create('books', body: {
                                      "name": nombreLibro.text,
                                      'author': authorLibro.text,
                                      "genre": generoLibro.text,
                                      "link": linkLibro.text,
                                    }, files: [
                                      multipartFile
                                    ]);

                                       await libroProvider.getTemas();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Se agrego exitosamente el libro' /* Ingresar */,
                                          ),
                                        ),
                                      
                                    );
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'No se pudo agregar el libro' /* Ingresar */,
                                          
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Ingrese una foto' /* Ingresar */,
                                        
                                      ),
                                    ),
                                  );
                                }
                              },
                              text: 
                                'Agregar libro' /* Agregar Evento */,
                              
                              // icon: Icon(
                              //   Icons.event_available,
                              //   color: AppTheme.of(context).alternate,
                              //   size: 15,
                              // ),
                              options: ButtonOptions(
                                width: 400,
                                height: 50,
                                color: Colors.purple,
                                textStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 0,
                                ),
                                borderRadius: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _getInputDecoration(
    BuildContext context,
    String labelText,
    String hintText,
  ) {
    return InputDecoration(
      labelText: 
        labelText /* Nombre de Evento */,
      
      labelStyle: TextStyle(
            fontFamily: 'Roboto',
            color:Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
      hintText: 
        hintText /* Nombre del Evento... */,
      
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.purple,
    );
  }

  Widget getImage(String? image) {
    //TODO: imagen de camara como placeholder
    if (image == null) {
      return Transform.scale(
        scale: 0.5,
        child: const Image(
          image: AssetImage('assets/images/no-image.jpg'),
          fit: BoxFit.contain,
        ),
      );
    } else if (image.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/images/no-image.jpg'),
        image: NetworkImage(image),
        fit: BoxFit.contain,
      );
    }
    return Image.file(
      File(image),
      fit: BoxFit.cover,
    );
  }
}