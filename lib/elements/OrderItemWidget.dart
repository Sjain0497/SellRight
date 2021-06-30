import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mvc_pattern/mvc_pattern.dart';
import '../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/Order.dart';
import '../models/route_argument.dart';
import '../constant/app_properties.dart';
import '../helpers/app_config.dart' as config;
import '../elements/BlockButtonWidget.dart';
import '../controller/order_controller.dart';

class OrderItemWidget extends StatefulWidget {
  final bool expanded;
  final Order order;
  final ValueChanged<void> onCanceled;

  OrderItemWidget({Key key, this.expanded, this.order, this.onCanceled})
      : super(key: key);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends StateMVC<OrderItemWidget> {
  String dropdownValue = 'Accept';
  OrderController _con;
  String orderStatus = "";
  _OrderItemWidgetState() : super(OrderController()) {
    _con = controller;
  }

  List<String> spinnerItems = [
    'Accept',
    'Reject',
    'Delivered',
  ];
  @override
  Widget build(BuildContext context) {
    print("OrderStstua...${widget.order.order_status}");
    orderStatus = widget.order.order_status;
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.all(10.0),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(1.0),
                border: Border.all(color: darkGrey, width: 1.0),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //         <--- border radius here
                    ),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Theme(
                data: theme,
                child: ExpansionTile(
                  initiallyExpanded: widget.expanded,
                  title: Column(
                    children: <Widget>[
                      Text(
                        '${S.of(context).order_id}: #${widget.order.order_id}',
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.order.created_at.toString(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${widget.order.total_price}',
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.order.payment_type}',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                  children: <Widget>[
                    Column(children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: widget.order?.order_id,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: CachedNetworkImage(
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  imageUrl: widget.order.image,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/loading.gif',
                                    fit: BoxFit.cover,
                                    height: 60,
                                    width: 60,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.order.product,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        Text(
                                          widget.order.description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Row(
                                          children: [
                                            orderStatus.isEmpty
                                                ? DropdownButton<String>(
                                                    value: dropdownValue,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    style: TextStyle(
                                                        color: blueColor,
                                                        fontSize: 18),
                                                    onChanged: (String data) {
                                                      setState(() {
                                                        dropdownValue = data;
                                                      });
                                                    },
                                                    items: spinnerItems.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  )
                                                : DropdownButton<String>(
                                                    value: orderStatus,
                                                    icon: Icon(
                                                        Icons.arrow_drop_down),
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    style: TextStyle(
                                                        color: blueColor,
                                                        fontSize: 18),
                                                    onChanged: (String data) {
                                                      setState(() {
                                                        dropdownValue = data;
                                                      });
                                                    },
                                                    items: spinnerItems.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                              ),
                                              child: FlatButton(
                                                onPressed: () {
                                                  _con.dochangeOrderStatus(
                                                      widget.order,
                                                      dropdownValue);
                                                  print(
                                                      "DropDownValue...$dropdownValue");
                                                  //  Navigator.of(context).pop();
                                                },
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3, vertical: 3),
                                                color: blueColor,
                                                shape: StadiumBorder(),
                                                child: Text(
                                                  'Done',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Helper.getPrice(
                                          Helper.getOrderPrice(
                                              widget.order.price),
                                          context,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                      Text(
                                        " x " +
                                            widget.order.quantity.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
