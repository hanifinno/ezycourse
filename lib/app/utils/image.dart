import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../config/api_constant.dart';
import 'color.dart';


String getFormatedProfileUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/$path';
}

String getFormatedGroupProfileUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/group/$path';
}

String getFormatedPageProfileUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/pages/$path';
}

String getFormatedStoryUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/story/$path';
}

String getFormatedPostUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/posts/$path';
}

String getFormatedHelpSupportUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/support/$path';
}

String getFormatedPagesUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/pages/posts/$path';
}

String getFormatedReelUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/reels/$path';
}

String getFormatedProfileReelUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/reels/thumbnails/$path';
}

String getFormatedVideoUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/posts/$path';
}

String getFormatedThumbnailUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/posts/thumbnails/$path';
}

String getFormatedAdsUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/adsStorage/$path';
}

String getFormatedProductUrl(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/product/$path';
}

String getFormatedProductUrlLive(String path) {
  return 'https://quantumpossibilities.eu:82/uploads/product/$path';
}

String getFormatedStoreUrlLive(String path) {
  return 'https://quantumpossibilities.eu:82/uploads/store/$path';
}

String getFormatedReturnQrUrlLive(String path) {
  return 'https://quantumpossibilities.eu:82/uploads/qr_code/$path';
}

String getFormatedProductReviewUrlLive(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/reviews/$path';
}

String getFormatedProductOrderReFundUrlLive(String path) {
  return '${ApiConstant.SERVER_IP_PORT}/uploads/order_refund/$path';
}

const allImgageType = [
  'jpg',
  'jpeg',
  'jfif',
  'pjpeg',
  'pjp',
  'gif',
  'png',
  'svg',
  'bmp'
];
const allVideoType = [
  'ogg',
  'webm',
  'mp4',
  'avi',
  'mov',
  'wmv',
  'mkv',
];

bool isImageUrl(String url) {
  String extension = url.split('.').last;
  for (String imageType in allImgageType) {
    if (imageType == extension) {
      return true;
    }
  }
  return false;
}

Future<List<dio.MultipartFile>> getMultipartFilesFromXfiles(
    List<XFile> xfiles) async {
  List<dio.MultipartFile> multiPartFileList = [];

  for (XFile file in xfiles) {
    multiPartFileList.add(dio.MultipartFile.fromBytes(await file.readAsBytes(),
        filename: file.path.split('/').last,
        contentType: getMediaTypeFromXFile(file)));
  }
  return multiPartFileList;
}

Future<File?> cropImage(File imageFile) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: PRIMARY_COLOR,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Crop Image',
      ),
    ],
  );

  if (croppedFile != null) {
    File file = File(croppedFile.path);
    return file;
  } else {
    return null;
  }
}

MediaType getMediaTypeFromXFile(XFile file) {
  String fileExtension = file.path.split('.').last.toLowerCase();

  switch (fileExtension) {
    case 'pdf':
      return MediaType.parse('application/pdf');
    case 'jpeg':
    case 'jpg':
      return MediaType.parse('image/jpeg');
    case 'png':
      return MediaType.parse('image/png');
    case 'gif':
      return MediaType.parse('image/gif');
    case 'bmp':
      return MediaType.parse('image/bmp');
    case 'webp':
      return MediaType.parse('image/webp');
    case 'svg':
      return MediaType.parse('image/svg+xml');
    case 'mp4':
      return MediaType.parse('video/mp4');
    case 'mkv':
      return MediaType.parse('video/x-matroska');
    case 'avi':
      return MediaType.parse('video/x-msvideo');
    case 'mov':
      return MediaType.parse('video/quicktime');
    case 'flv':
      return MediaType.parse('video/x-flv');
    default:
      return MediaType.parse('application/octet-stream'); // Default binary type
  }
}
