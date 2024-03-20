import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:chat_app/features/chat/manager/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChatCubit>(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
        actions: [
          IconButton(
            onPressed: () async => await authCubit.logout(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<ChatCubit, ChatState>(
                  bloc: cubit,
                  buildWhen: (previous, current) => current is ChatSuccess,
                  listener: (context, state) {
                    if (state is MessageSent) {
                      _messageController.clear();
                    }
                  },
                  builder: (context, state) {
                    if (state is ChatSuccess) {
                      final messages = state.messages;
                      final currentUserId = state.currentUserId;

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return currentUserId == message.senderId
                              ? Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(message.senderPhoto),
                                    ),
                                    title: Text(message.message),
                                    subtitle: Text(
                                      message.senderName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                            color: Colors.orange,
                                          ),
                                    ),
                                  ),
                              )
                              : ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(message.senderPhoto),
                                  ),
                                  title: Text(message.message),
                                  subtitle: Text(
                                    message.senderName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: Colors.blue,
                                        ),
                                  ),
                                );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              const Divider(height: 1),
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: InputBorder.none,
                  hintText: 'Type a message',
                  suffixIcon: IconButton(
                    onPressed: () async =>
                        await cubit.sendMessage(_messageController.text),
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
