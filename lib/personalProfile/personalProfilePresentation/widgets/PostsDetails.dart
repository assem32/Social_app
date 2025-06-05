import 'package:flutter/material.dart';

class PostsDetails extends StatelessWidget {
  final int length;
  const PostsDetails(this.length,{super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            const Text('Posts'),
                            Text(
                              '$length',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('Posts'),
                            Text(
                              '100',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('Posts'),
                            Text(
                              '100',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('Posts'),
                            Text(
                              '100',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
  }
}