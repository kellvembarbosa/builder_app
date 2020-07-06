//library wordpressapi;


import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' show Dio, Options, ResponseType;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

class WordPressAPI {
  String site, _link;
  String _apiNamespace = 'wp/v2';
  final bool isWooCommerce;
  final bool isHttps;
  final String consumerKey, consumerSecret;
  final Dio _client = Dio();

  // INITIALIZATION
  WordPressAPI(
      /// [String] WP powered website
      this.site, {

        /// [String] WooCommerce consumer key.
        this.consumerKey = '',

        /// [String] WooCommerce consumer secret.
        this.consumerSecret = '',
        /// [bool] Is woocommerce installed?
        this.isWooCommerce = false,
        /// https for all request
        this.isHttps = false
      }){
        _client.interceptors.add(DioCacheManager(CacheConfig(baseUrl: this.site)).interceptor);
      }

  // DISCOVER API LINK FROM HEADER //
  Future<String> _getLink() async {
    if (!site.startsWith('http')) {
      site = '${isHttps ? 'https://$site' : 'http://$site'}'.toLowerCase();
      //site = 'http://${site.toLowerCase()}';
      print('SITE: $site');
    }

    final res = await _client.head(site);
    if (res.statusCode == 200) {
      if (res.headers['link'] != null) {
        final links = res.headers['link'].toString().split(';')[0].replaceFirst('[<', '').replaceFirst('>', '');
        //debugPrint("header: ${res.headers.toString()}");
        //debugPrint('wordpressAPI: ${links.replaceFirst('[<', '').replaceFirst('>', '')}');
        return links;
      } else {
        return '$site/wp-json/';
      }
    } else {
      throw Exception('Failed to get $site json endpoint');
    }
  }

  // GET DATA FROM CUSTOM ENDPOINT //
  /// Retrieves data from a given endpoint
  /// The 'data' key contains the raw json data
  /// The 'meta' key is map with two keys, total and totalPages
  Future<Map<String, dynamic>> getAsync(
      String endpoint, {
        String namespace,
      }) async {

    debugPrint("getAsync() ");
    final url = await _getLink();
    debugPrint("getAsync() $url");
    if (endpoint.startsWith('/')) {

      endpoint = endpoint.substring(1);
      // print("ENDPOINT: $endpoint");
    }

    if (url.contains('?') && endpoint.contains('?')) {
      endpoint = endpoint.replaceAll('?', '&');
      // print("ENDPOINT: $endpoint");
    }

    if (namespace != null) {
      // CHECK IF NAMESPACE HAS A TRAILING SLASH
      if (namespace.endsWith('/')) {
        _apiNamespace =
            namespace.substring(0, namespace.length - 1).toLowerCase();
        _link = '$url$_apiNamespace/$endpoint';
        // print('NAMESPACED LINK: $_link');
      } else {
        _apiNamespace = namespace;
        _link = '$url$_apiNamespace/$endpoint';
        // print('NAMESPACED LINK: $_link');
      }
    }

    // WOOCOMMERCE SETTINGS
    if (isWooCommerce) {
      String credentials =
          'consumer_key=$consumerKey&consumer_secret=$consumerSecret';
      // SET WOOCOMMERCE NAMESPACE
      _apiNamespace = 'wc/v3/';
      // CHECK IF ENDPOINT HAS A QUERY
      if (endpoint.contains('?')) {
        _link = '$url$_apiNamespace$endpoint&$credentials';
        // print('WC /?: $_link');
      } else {
        _link = '$url$_apiNamespace$endpoint?$credentials';
        // print('WC URL: $_link');
      }
    } else {
      _link = '$url$_apiNamespace/$endpoint';
      // print('GET LINK: $_link');
    }

    try {
      final res = await _client.get(_link, options: buildCacheOptions(Duration(days: 7), forceRefresh: true));//, options: Options(responseType: ResponseType.json));
      int total;
      int totalPages;

      //debugPrint("res: ${res.headers.toString()}");

      // Check if total is in header
      if (res.headers['x-wp-total'].toString().isNotEmpty) {
        String totaly = "${res.headers['x-wp-total'].toString().replaceFirst('[', '').replaceFirst(']', '')}";
        total = int.parse(totaly);
      }

      // check if total pages is in header
      if (res.headers['x-wp-totalpages'].toString().isNotEmpty) {
        debugPrint("${res.headers['x-wp-totalpages'].toString().replaceFirst('[', '').replaceFirst(']', '')} " );

        String totalPagesy = "${res.headers['x-wp-totalpages'].toString().replaceFirst('[', '').replaceFirst(']', '')}";
        totalPages = int.parse(totalPagesy);
      }

      debugPrint("passed if ${res.statusCode}");

      return {
        'data': res.data,
        'meta': {'total': total, 'totalPages': totalPages},
        'statusCode': res.statusCode
      };
    } catch (e) {
      throw Exception(e);
    }
  }

  // **************** WP STANDARD ENDPOINTS ************** //
  // GET CATEGORIES //
  Future<Map<String, dynamic>> getCategories() async {
    return await getAsync('categories');
  }

  // GET COMMENTS //
  Future<Map<String, dynamic>> getComments() async {
    return await getAsync('comments');
  }

  // GET POSTS //
  Future<Map<String, dynamic>> getPosts() async {
    return await getAsync('posts');
  }

  // WP SEARCH //
  // GET TAGS //
  Future<Map<String, dynamic>> getTags() async {
    return await getAsync('tags');
  }

  // GET USERS //
  Future<Map<String, dynamic>> getUsers() async {
    return await getAsync('users');
  }

// **************** WOOCOMMERCE ENDPOINTS | TO DO *************** //
}
