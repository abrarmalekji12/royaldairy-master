
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/brand_model.dart';
import '../models/amul_details.dart';
class Brands with ChangeNotifier {
  List<BrandModal> _brands = [
           BrandModal(
        brandId: DateTime.now().toString(),
        brandName: 'Amul',
        brandPhoto: 'assets/images/amul/amul.jpg',
        items:[
           ProductModal(
        productId: 'Amul1',
        photo: 'assets/images/amul/amul_gold.png',
        typeId: 'cow1',
        name: 'Amul Gold',
        price: 49.00,
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul2',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Deshi A2 cow Milk',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul3',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Cow Milk',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul4',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Diamond',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul5',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Buffelo milk',
        price: 49.00,
        typeId:'buffelo1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul6',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Camel milk',
        price: 49.00,
        typeId:'camel1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul7',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Camel Long Life Milk',
        price: 49.00,
        typeId: 'camel1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Amul8',
        name: 'Amul Taza',
        price: 64.00,
        photo: 'assets/images/amul/amul_taza.png',
        typeId: 'cow1',
        description: 'Pasteurised Milk Amul milk meets the PFA standards for the respective type of milk',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Amul9',
        name: 'Amul Shakti',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Amul10',
        name: 'Amul Lactos free milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false)
        ]),
    
   
     BrandModal(
        brandId: DateTime.now().toString(),

        brandName: 'Gokul',
        brandPhoto: 'assets/images/gokul/gokul.png',
        items:[
          ProductModal(
        productId: 'Gokul2',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Full Cream Milk',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Gokul3',
        name: 'Skim Milk',
        price: 64.00,
        photo: 'assets/images/amul/amul_taza.png',
        typeId: 'cow1',
        description: 'Pasteurised Milk Amul milk meets the PFA standards for the respective type of milk',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Gokul4',
        name: 'Gokul Cow milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        typeId: 'cow1',
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',

        isFavorite:false),
    ProductModal(
        productId: 'Gokul5',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Taaza',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
        ]),
     BrandModal(
        brandId: DateTime.now().toString(),
        brandName: 'Maahi',
        brandPhoto: 'assets/images/maahi/mahi.png',
        items:[
          ProductModal(
        productId: 'Maahi',
        name: 'Maahi Gold',
        price: 64.00,
        photo: 'assets/images/amul/amul_taza.png',
        typeId: 'cow1',
        description: 'Pasteurised Milk Amul milk meets the PFA standards for the respective type of milk',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Maahi2',
        name: 'Super Gold',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
    ProductModal(
        productId: 'Maahi3',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Maahi Lite',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Maahi4',
        name: 'Chai Shakti',
        price: 64.00,
        photo: 'assets/images/amul/amul_taza.png',
        typeId: 'cow1',
        description: 'Pasteurised Milk Amul milk meets the PFA standards for the respective type of milk',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
        ]),
     BrandModal(
        brandId: DateTime.now().toString(),
        brandName: 'Milma',
        brandPhoto: 'assets/images/milma/milma.png',
        items:[
          ProductModal(
        productId: 'Milma2',
        name: 'Long Life Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
      ProductModal(
        productId: 'Milma3',
        name: 'Standardised Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
        ]),
     BrandModal(
        brandId: DateTime.now().toString(),
        brandName: 'Nandini',
        brandPhoto: 'assets/images/nandini/nandni.jpg',
        items:[
          ProductModal(
        productId: 'Nandini2',
        name: 'Pasteurised Toned Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
     ProductModal(
        productId: 'Nandini3',
        name: 'Double Toned Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Nandini4',
        name: 'Cow Pure Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Nandini5',
        name: 'Special Toned Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
        ]),
     BrandModal(
        brandId: DateTime.now().toString(),
        brandName: 'Mother Dairy',
        brandPhoto: 'assets/images/mother/md.png',
        items:[
          ProductModal(
        productId: 'Mother Dairy1',
        name: 'Ultra Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Mother Dairy2',
        name: 'Full Cream Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
      ProductModal(
        productId: 'Mother Dairy3',
        name: 'Toned Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:true),
      ProductModal(
        productId: 'Mother Dairy4',
        name: 'Live Lite',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Mother Dairy4',
        name: 'Mother Dairy cow milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
        ])
       
  ];
  List<BrandModal> b1=[BrandModal(
    brandId: 'cow1',
     brandName: 'types',
      brandPhoto: 'assets/images/types/goat_milk.jpg', 
      items:[
              ProductModal(
        productId: 'Amul1',
        photo: 'assets/images/amul/amul_gold.png',
        typeId: 'cow1',
        name: 'Amul Gold',
        price: 49.00,
        
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul2',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Deshi A2 cow Milk',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul3',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Cow Milk',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul4',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Diamond',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul8',
        name: 'Amul Taza',
        price: 64.00,
        photo: 'assets/images/amul/amul_taza.png',
        typeId: 'cow1',
        description: 'Pasteurised Milk Amul milk meets the PFA standards for the respective type of milk',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Amul9',
        name: 'Amul Shakti',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Amul10',
        name: 'Amul Lactos free milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
          ProductModal(
        productId: 'Gokul2',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Full Cream Milk',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Gokul3',
        name: 'Skim Milk',
        price: 64.00,
        photo: 'assets/images/amul/amul_taza.png',
        typeId: 'cow1',
        description: 'Pasteurised Milk Amul milk meets the PFA standards for the respective type of milk',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Gokul4',
        name: 'Gokul Cow milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        typeId: 'cow1',
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        
        isFavorite:false),
    ProductModal(
        productId: 'Gokul5',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Taaza',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
          ProductModal(
        productId: 'Maahi',
        name: 'Maahi Gold',
        price: 64.00,
        photo: 'assets/images/amul/amul_taza.png',
        typeId: 'cow1',
        description: 'Pasteurised Milk Amul milk meets the PFA standards for the respective type of milk',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Maahi2',
        name: 'Super Gold',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
    ProductModal(
        productId: 'Maahi3',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Maahi Lite',
        price: 49.00,
        typeId: 'cow1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
    ProductModal(
        productId: 'Maahi4',
        name: 'Chai Shakti',
        price: 64.00,
        photo: 'assets/images/amul/amul_taza.png',
        typeId: 'cow1',
        description: 'Pasteurised Milk Amul milk meets the PFA standards for the respective type of milk',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
        ProductModal(
        productId: 'Nandini2',
        name: 'Pasteurised Toned Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
     ProductModal(
        productId: 'Nandini3',
        name: 'Double Toned Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Nandini4',
        name: 'Cow Pure Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Nandini5',
        name: 'Special Toned Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
         ProductModal(
        productId: 'Mother Dairy1',
        name: 'Ultra Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Mother Dairy2',
        name: 'Full Cream Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
      ProductModal(
        productId: 'Mother Dairy3',
        name: 'Toned Milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:true),
      ProductModal(
        productId: 'Mother Dairy4',
        name: 'Live Lite',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
       ProductModal(
        productId: 'Mother Dairy4',
        name: 'Mother Dairy cow milk',
        photo: 'assets/images/amul/amul_shakti.png',
        price: 50.00,
        description: 'It is pasteurized in state-of-the-art processing plants and pouch-packed to make it conveniently available to consumers',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        typeId: 'cow1',
        isFavorite:false),
        
        ],
        
        ),
        
        BrandModal(brandId: 'camel1', brandName: 'Camel', brandPhoto: null, items: [
           ProductModal(
        productId: 'Amul6',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Camel milk',
        price: 49.00,
        typeId:'camel1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
         ProductModal(
        productId: 'Amul7',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Camel Long Life Milk',
        price: 49.00,
        typeId: 'camel1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
        ]),
        BrandModal(brandId: 'buffelo1', brandName: 'buffelo', brandPhoto: null, items: [
            ProductModal(
        productId: 'Amul5',
        photo: 'assets/images/amul/amul_gold.png',
        name: 'Amul Buffelo milk',
        price: 49.00,
        typeId:'buffelo1',
        description: 'Pasteurised milk Amul milk meets the FSSA standards for the respective type of milk.',
        composition: 'FAT(%) 6.0 min SNF (%)* 9.0 min',
        isFavorite:false),
        ])
       ];


   
    
   
  List<BrandModal>  get brands{

      
    return [..._brands];
  }
  
  List<ProductModal> get ShowFavScreen
    {
      List<ProductModal> datas=[];
       _brands.forEach((data){
             data.items.forEach((data){
               datas.add(data);
             });
           });
           return datas.where((data)=>data.isFavorite).toList();
    }
    int get ShowFavScreenLength
    {
      return  _brands.where((data){
             data.items.where((data){
               data.isFavorite;
             });
           }).toList().length;
    }
    
    
  BrandModal findByIdOfType(String id)
    {
      return b1.firstWhere((data)=>data.brandId==id);
     
    }

  BrandModal findById(String id)
    {
        return _brands.firstWhere((pro)=>pro.brandId==id);
    }
  
  
  
  
}
