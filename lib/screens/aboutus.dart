import 'package:url_launcher/url_launcher.dart';

import '../generated/l10n.dart';
import '../elements/AboutListItem.dart';
import '../elements/MySliverAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

class AboutUsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  AboutUsWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _AboutUsWidgetState createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends StateMVC<AboutUsWidget> {
  Future<void> _launched;
  bool _termsChecked = false;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          S.of(context).about,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),

      ),
        extendBodyBehindAppBar: true,
      body: Container(
        width: config.App(context).appWidth(100),
        height: config.App(context).appHeight(100),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/my_Catalouge_Back.jpg',
            ),
            fit: BoxFit.cover,
          ),
          /* color: Theme.of(context).accentColor*/
        ),
        child: CustomScrollView(
          slivers: [
            // SliverPersistentHeader(
            //   delegate: MySliverAppBar(expandedHeight: 100),
            //   pinned: true,
            // ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  SizedBox(
                    height: 100,
                    width: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Catalog maker of Sell Right allows you to create stunning product catalogs on the run and share them with your customers in minutes. Sell Right offers sharing across all digital platforms, including Whatsapp, WhatsApp Business, Facebook, Instagram, SMS, Email, and a bunch of others',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Create your catalogs quickly. Simply select the items you wish to share from your phone gallery, camera, or existing products, give it a catchy title, and your new catalog is ready in seconds. Go ahead and dazzle your potential buyers',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 15,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                         'You can share on WhatsApp, WhatsApp Business, Instagram, SMS, Email, Facebook, and a range of other social media platforms. Share your catalogs as a link on WhatsApp, Facebook, or SMS within seconds. Increase your sales by a huge margin!',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Maintain an up-to-date product inventory that can be shared from anywhere and at any time. Be the first to contact potential buyers!',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Best features of Wholesale and B2B. Take your wholesale and manufacturing business online now by selling your products in packages of sizes or colors or by requiring a minimum order quantity for each product.',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                           'Determine which buyers are interested and when to contact them. The comprehensive customer analytics package in Sell Right gives you in-depth insight into how customers interact with your catalogs. You can now stay on top of your game at all times!',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 15,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Determine which products are in high demand and forecast demand. Find out which items are popular with customers and stock up for a big sale! ',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Never be concerned about someone misusing your product information. Your catalogs will never fall into the wrong hands if you use Sell Right\'s Privacy Module. Customers and competitors won\'t be able to see your catalogs and only selected customers will be able to see your products.',  textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Keep everyone on the same page and empower your whole sales team with the most up-to-date inventory and product information.',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Set delivery costs for the inside city, country, and worldwide, with choices for weight-based postage or free shipping for orders exceeding a certain amount.',
                                textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                          ),
                        ),
                        new ListTile(
                          leading: new AboutListItem(),
                          title: new Text(
                            'Share your products as photos, link, PDF or Brochure'
                                ,textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () => setState(() {
                        //     Navigator.pushNamed(context, '/TermsAndCondition');
                        //     //  _launched = _launchInWebViewOrVC(toLaunch);
                        //   }),
                        //   child: const Text('Our Terms And Condition'),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
