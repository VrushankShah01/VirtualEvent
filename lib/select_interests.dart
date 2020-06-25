import 'dart:convert';

import 'package:evento/ConstantUrls.dart';
import 'package:evento/profile.dart';
import 'package:evento/widgets/loaders/loading.dart';
import 'package:evento/widgets/popups/success_popup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectInterests extends StatefulWidget
{
  final String name, email, id;

  SelectInterests({this.email, this.name, this.id});

  @override
  _SelectInterestsState createState() => _SelectInterestsState();
}

List<String> interestList = List<String>();

class _SelectInterestsState extends State<SelectInterests>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select your area of interests",
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.0,
                      color: Colors.white,
                      fontFamily: "Helv",
                    ),
                  ),
                ),

                SizedBox(height: 50,),
                
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: <Widget>
                  [
                    FilterChipWidget(chipName: "Consulting", bgColor: Colors.transparent, selectedColor: Colors.amberAccent, textColor: Colors.blue, selectedTextColor: Colors.white,),
                    FilterChipWidget(chipName: "Product Management", bgColor: Colors.transparent, selectedColor: Colors.redAccent, textColor: Colors.blue, selectedTextColor: Colors.white,),
                    FilterChipWidget(chipName: "Telecommunication", bgColor: Colors.transparent, selectedColor: Colors.deepOrangeAccent, textColor: Colors.blue, selectedTextColor: Colors.white,),
                    FilterChipWidget(chipName: "Advisor", bgColor: Colors.transparent, selectedColor: Colors.greenAccent[700], textColor: Colors.blue, selectedTextColor: Colors.white,),
                    FilterChipWidget(chipName: "Manufacturer", bgColor: Colors.transparent, selectedColor: Colors.pinkAccent, textColor: Colors.blue, selectedTextColor: Colors.white,),
                    FilterChipWidget(chipName: "Retailer", bgColor: Colors.transparent, selectedColor: Colors.indigo, textColor: Colors.blue, selectedTextColor: Colors.white,),
                    FilterChipWidget(chipName: "Distributor", bgColor: Colors.transparent, selectedColor: Colors.purple, textColor: Colors.blue, selectedTextColor: Colors.white,),
                    FilterChipWidget(chipName: "Marketing Manager", bgColor: Colors.transparent, selectedColor: Colors.deepPurple, textColor: Colors.blue, selectedTextColor: Colors.white,),
                    FilterChipWidget(chipName: "IT Development", bgColor: Colors.transparent, selectedColor: Colors.orange, textColor: Colors.blue, selectedTextColor: Colors.white,),

                  ],
                ),

                SizedBox(height: 50,),

                IconButton(
                  onPressed: ()
                  {
                    print("Clicked");

                    // No interests selected
                    if(interestList.length <= 0)
                    {
                      setState(()
                      {
                        showDialog(
                          context: context,
                          builder: (_)
                          {
                            return ContinueWithoutInterests(name: widget.name, email: widget.email, id: widget.id,);
                          }
                        );
                      });

                      print("List empty");
                    }

                    // Interests selected
                    else
                    {
                      storeInterests();

                      print("List not empty");
                    }
                  },
                  icon: Icon(
                    Icons.navigate_next,
                    size: 45,
                  ),
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  storeInterests() async
  {
    setState(()
    {
      // Show Loader
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_)
          {
            return Loader();
          }
      );
    });

    var response = await http.post(ConstantUrls.InterestsSelectedUrl, body:
                   {
                     "verify" : "TheCandidoVirtualEvent2020",
                     "interests" : json.encode(interestList),
                     "txtUserId" : widget.id.toString(),
                   });

    print("RESPONSE :  " + response.body);

    var message = jsonDecode(response.body);

    if(message["msg"].toString() == "success")
    {
      Navigator.of(context).pop(Loader);

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => ProfileScreen(name: widget.name, email: widget.email)));
    }
    else if(message["msg"].toString() == "fail")
    {
      Navigator.of(context).pop(Loader);

      setState(()
      {
        showDialog(
            context: context,
            builder: (_)
            {
              return SuccessPopup(
                title: "Error!",
                isSuccessfull: false,
                message: "Something went wrong. Please try again!",
              );
            }
        );
      });
    }
    else if(message["msg"].toString() == "yes")
    {
      Navigator.of(context).pop(Loader);

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => ProfileScreen(name: widget.name, email: widget.email)));
    }
    else
    {
      Navigator.of(context).pop(Loader);

      setState(()
      {
        showDialog(
            context: context,
            builder: (_)
            {
              return SuccessPopup(
                title: "Error!",
                isSuccessfull: false,
                message: "Something went wrong. Please try again!",
              );
            }
        );
      });
    }
  }
}

class FilterChipWidget extends StatefulWidget
{
  final String chipName;
  final Color bgColor;
  final Color selectedColor;
  final Color textColor;
  final Color selectedTextColor;

  FilterChipWidget({this.chipName, this.bgColor, this.selectedColor, this.textColor, this.selectedTextColor});

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget>
{
  var _isSelected = false;

  @override
  Widget build(BuildContext context)
  {
    return FilterChip(
      label: Text(
        widget.chipName,
        style: TextStyle(
            letterSpacing: 1.1,
            color: _isSelected ? widget.selectedTextColor : widget.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 17
        ),
      ),
      selected: _isSelected,
      backgroundColor: widget.bgColor,
      onSelected: (isSelected)
      {
        setState(()
        {
          _isSelected = isSelected;
          print("IS SELECTED : " + _isSelected.toString());

          if(isSelected)
          {
            interestList.add(widget.chipName);
            print(interestList.toString());
          }
          else
          {
            interestList.remove(widget.chipName);
            print(interestList.toString());
          }
        });
      },
      selectedColor: widget.selectedColor,
      padding: EdgeInsets.all(8),
      elevation: 2,
      showCheckmark: false,
    );
  }
}

// No interests selected Popup
class ContinueWithoutInterests extends StatefulWidget
{
  final String name, email, id;

  ContinueWithoutInterests({this.email, this.name, this.id});

  @override
  _ContinueWithoutInterestsState createState() => _ContinueWithoutInterestsState();
}

class _ContinueWithoutInterestsState extends State<ContinueWithoutInterests>
{
  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Continue without selecting areas of interests ?",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.0,
                    color: Colors.black
                  ),
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>
                [
                  FlatButton(
                    onPressed: ()
                    {
                      storeNoInterestSelected();
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(5),
                  ),

                  FlatButton(
                    onPressed: ()
                    {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(5),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Store No Interest Selected in Db
  storeNoInterestSelected() async
  {
    setState(()
    {
      showDialog(
        context: context,
        builder: (_)
        {
          return Loader();
        }
      );
    });

    print("ID : " + widget.id.toString());

    var response = await http.post(ConstantUrls.NoInterestsSelectedUrl, body:
                   {
                     "verify" : "TheCandidoVirtualEvent2020",
                     "txtUserId" : widget.id.toString(),
                   });

    print("MESSAGE : " + response.body);

    var message = jsonDecode(response.body);


    if(message["msg"].toString() == "success")
    {
      Navigator.of(context).pop(Loader);

      Navigator.of(context).pop(ContinueWithoutInterests);

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => ProfileScreen(name: widget.name, email: widget.email)));
    }
    else if(message["msg"].toString() == "fail")
    {
      Navigator.of(context).pop(Loader);

      Navigator.of(context).pop(ContinueWithoutInterests);

      setState(()
      {
        showDialog(
            context: context,
            builder: (_)
            {
              return SuccessPopup(
                title: "Error!",
                isSuccessfull: false,
                message: "Something went wrong. Please try again!",
              );
            }
        );
      });
    }
    else if(message["msg"].toString() == "yes")
    {
      Navigator.of(context).pop(Loader);

      Navigator.of(context).pop(ContinueWithoutInterests);

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => ProfileScreen(name: widget.name, email: widget.email)));
    }
    else
    {
      Navigator.of(context).pop(Loader);

      Navigator.of(context).pop(ContinueWithoutInterests);

      setState(()
      {
        showDialog(
          context: context,
          builder: (_)
          {
            return SuccessPopup(
              title: "Error!",
              isSuccessfull: false,
              message: "Something went wrong. Please try again!",
            );
          }
        );
      });
    }
  }
}


