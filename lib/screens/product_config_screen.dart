import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductConfigScreen extends StatefulWidget {
  const ProductConfigScreen({super.key});
  static const routeName = '/config-product';

  @override
  State<ProductConfigScreen> createState() => _ProductConfigScreenState();
}

class _ProductConfigScreenState extends State<ProductConfigScreen> {
  static const int defaultProductId = -1;
  bool isInit = true;

  final _focusNode = FocusNode();

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  ProductModel _productModel = ProductModel(
      id: defaultProductId, title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      var arguments = ModalRoute.of(context)!.settings.arguments;
      if (arguments != null) {
        int productId = arguments as int;
        _productModel = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
      }
    }
    _imageUrlController.text = _productModel.getImageUrl;
    isInit = false;
    super.didChangeDependencies();
  }

  // things need to be disposed after used.
  @override
  void dispose() {
    _focusNode.dispose();

    _imageUrlFocusNode.removeListener(_updateImageUrl);

    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    ;
    _formKey.currentState?.save();
    if (_productModel.getId == defaultProductId) {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_productModel);
    }
    Navigator.of(context).pop();
    print(_productModel.getTitle);
    print(_productModel.getPrice);
    print(_productModel.getDescription);
    print(_productModel.getImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Configuration'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                initialValue: _productModel.getTitle,
                onSaved: (newValue) {
                  _productModel.setTitle = newValue;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title cannot be blank';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                initialValue: _productModel.getPrice == 0
                    ? ''
                    : _productModel.getPrice.toString(),
                onSaved: (newValue) {
                  _productModel.setPrice = double.parse(newValue!);
                },
                validator: (value) {
                  var amountValue = double.tryParse(value!);
                  if (amountValue == null) {
                    return 'Please input a valid number';
                  }
                  if (amountValue <= 0) {
                    return 'Price must be greater than 0';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Decription'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                initialValue: _productModel.getDescription,
                onSaved: (newValue) {
                  _productModel.setDescription = newValue;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            fit: BoxFit.contain,
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (newValue) {
                        _productModel.setImageUrl = newValue;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => {
                  FocusScope.of(context).requestFocus(_focusNode),
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _focusNode,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              )
            ],
          ),
        ),
      ),
    );
  }
}
