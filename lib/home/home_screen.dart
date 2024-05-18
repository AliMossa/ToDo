import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/home/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _showAddTaskDialog(BuildContext context, HomeBloc bloc) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider<HomeBloc>.value(
          value: bloc,
          child: AlertDialog(
            title: const Text("Add Task"),
            content: TextField(
              onChanged: (value) {
                context.read<HomeBloc>().data.newTodo = value;
              },
              decoration: const InputDecoration(hintText: 'Task'),
            ),
            actions: [
              BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
                if (state is SuccessNewData) {
                  Navigator.of(context).pop();
                } else if (state is FailNewData) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "Adding Data has been failed",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              }, builder: (_, state) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    context.read<HomeBloc>().add(AddDataEvent());
                  },
                  child: bloc.state is LoadingNewData
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Add Task',
                          style: TextStyle(color: Colors.white),
                        ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final moreInfo = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () => _showAddTaskDialog(context, context.read<HomeBloc>()),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(.8),
        title: const Text("To Do ", style: TextStyle(color: Colors.white)),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) async {
          print("the state is $state");


          if (state is ExceptionHomeData) {
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Fetching Data has been failed",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ));

            }else if(state is ExceptionNewData){
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Adding Data has been failed",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),);
          }else if(state is ExceptionUpdateData){
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Updating Data has been failed",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),);
          }else if(state is ExceptionDeleteData){
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Deleting Data has been failed",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),);
          }
        },
        child: SafeArea(
            child: context.watch<HomeBloc>().state is LoadingHomeData
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : context.watch<HomeBloc>().state is FailHomeData ||
                        context.watch<HomeBloc>().state is ExceptionHomeData
                    ? Image.asset(
                        'assets/error.png',
                        fit: BoxFit.cover,
                      )
                    : ListView.builder(
                            itemBuilder: (_, index) => InkWell(
                              onLongPress: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (_) {
                                    return
                                        BlocProvider<HomeBloc>.value(value: context.read<HomeBloc>(),child:
                                        AlertDialog(
                                          actionsOverflowAlignment:
                                          OverflowBarAlignment.center,
                                          title:
                                          context.watch<HomeBloc>().state is LoadingDeleteData || context.watch<HomeBloc>().state is LoadingUpdateData?const Text("Loading..."):
                                           const Text("Choose one"),
                                          actions: [

                                            BlocConsumer<HomeBloc,HomeState>(builder: (_,state)=>
                                            context.watch<HomeBloc>().state is LoadingDeleteData || context.watch<HomeBloc>().state is LoadingUpdateData
                                                ? const Center(
                                              child:
                                              CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            ):
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty
                                                        .all(Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<HomeBloc>()
                                                        .add(DeleteDataEvent(
                                                        index),);
                                                  },
                                                  child: const Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty
                                                        .all(Colors.blue),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<HomeBloc>()
                                                        .add(UpdateDataEvent(index));
                                                  },
                                                  child: const Text(
                                                    'Update',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ), listener: (_,state){
                                              if(state is SuccessDeleteData ||state is SuccessUpdateData ){
                                                Navigator.of(context).pop();
                                              }
                                            })

                                          ],
                                        ));
                                  },
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.blue)),
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          constraints: BoxConstraints(
                                              maxWidth: moreInfo.width * .7),
                                          child: Text(
                                            context
                                                .watch<HomeBloc>()
                                                .data
                                                .getName(index),
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          )),
                                      Text(context
                                          .watch<HomeBloc>()
                                          .data
                                          .getId(index)
                                          .toString()),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Complete : ${context.watch<HomeBloc>().data.getComplete(index)}"),
                                      Text(
                                          "User Id : ${context.watch<HomeBloc>().data.getUserId(index)}"),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            itemCount:
                                context.watch<HomeBloc>().data.getCount(),
                          ),

                      )
      ),
    );
  }
}
