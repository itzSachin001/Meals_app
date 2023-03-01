import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName='/filters';

  final Function setFilters;
  final Map<String,bool> currentFilters;

  FiltersScreen(this.currentFilters,this.setFilters);


  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  var _glutenFree=false;
  var _vegetarian=false;
  var _vegan=false;
  var _lactoseFree=false;

  @override
  void initState() {
    _glutenFree=widget.currentFilters['gluten']!;
    _vegetarian=widget.currentFilters['vegetarian']!;
    _vegan=widget.currentFilters['vegan']!;
    _lactoseFree=widget.currentFilters['lactose']!;

    super.initState();
  }

  Widget _buildSwitchListTile(String title,String subTitle,bool currValue,void Function(bool)? updateValue){
    return SwitchListTile(
        value: currValue,
        title:Text(title),
        subtitle:Text(subTitle),
        onChanged: updateValue,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Filters'),
        actions: [
          IconButton(onPressed: (){
              final selectedFilters={
                'gluten': _glutenFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
                'lactose': _lactoseFree,
              };
              widget.setFilters(selectedFilters);
              Navigator.of(context).pushReplacementNamed('/');

            }, icon: Icon(Icons.save),)
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding:const EdgeInsets.all(10),
            child: Text("Adjust your meal selection!",style: Theme.of(context).textTheme.titleMedium,),
          ),

          Expanded(
            child: ListView(
              children:[
                _buildSwitchListTile('Gluten-Free', 'Only included gluten-free meals!', _glutenFree,
                      (newValue){
                    setState(() {
                      _glutenFree=newValue;
                      }
                    );
                  }),

            _buildSwitchListTile('Vegetarian', 'Only included vegetarian meals!', _vegetarian,
                  (newValue){
                setState(() {
                  _vegetarian=newValue;
                }
                );
              },),

            _buildSwitchListTile('Vegan', 'Only included vegan meals!', _vegan,
                    (newValue){
                  setState(() {
                    _vegan=newValue;
                  }
                  );
                }),

            _buildSwitchListTile('Lactose-Free', 'Only included lactose-free meals!', _lactoseFree,
                    (newValue){
                  setState(() {
                    _lactoseFree=newValue;
                  }
                  );
                }),
    ],
      ),
          ),
    ],),);
  }
}
