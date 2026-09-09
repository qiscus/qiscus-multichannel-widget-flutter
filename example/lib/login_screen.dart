import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multichannel_flutter_sample/demo_config.dart';
import 'package:multichannel_flutter_sample/showcase_panel.dart'; // import for showcase triggers
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final DemoUiConfig config;
  final ValueChanged<DemoUiConfig> onConfigChanged;

  const LoginScreen({
    super.key,
    required this.config,
    required this.onConfigChanged,
  });

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final appIdController = TextEditingController(text: widget.config.appId);
  late final channelIdController =
      TextEditingController(text: widget.config.channelId);
  late final usernameController =
      TextEditingController(text: widget.config.userId);
  late final displayNameController =
      TextEditingController(text: widget.config.displayName);

  bool initiating = false;

  @override
  void dispose() {
    appIdController.dispose();
    channelIdController.dispose();
    usernameController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF55B29A), Color(0xFF34917C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Card(
                elevation: 8,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.chat_bubble_rounded,
                          size: 48, color: Color(0xFF34917C)),
                      const SizedBox(height: 16),
                      Text(
                        'Multichannel Live Chat',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF34917C)),
                      ),
                      const Text(
                        'Configuration Showcase',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 32),

                      // Account Section
                      _sectionHeader('1. Basic Configuration'),
                      _buildTextField(
                        controller: appIdController,
                        label: 'App ID',
                        icon: Icons.apps,
                        onChanged: (val) => widget.onConfigChanged(
                            widget.config.copyWith(appId: val)),
                      ),
                      _buildTextField(
                        controller: channelIdController,
                        label: 'Channel ID',
                        icon: Icons.alt_route,
                        onChanged: (val) => widget.onConfigChanged(
                            widget.config.copyWith(channelId: val)),
                      ),

                      const SizedBox(height: 16),
                      _sectionHeader('2. Identity Information'),
                      _buildTextField(
                        controller: usernameController,
                        label: 'User ID',
                        icon: Icons.person_outline,
                        onChanged: (val) => widget.onConfigChanged(
                            widget.config.copyWith(userId: val)),
                      ),
                      _buildTextField(
                        controller: displayNameController,
                        label: 'Display Name',
                        icon: Icons.badge_outlined,
                        onChanged: (val) => widget.onConfigChanged(
                            widget.config.copyWith(displayName: val)),
                      ),

                      const SizedBox(height: 16),
                      _sectionHeader('3. Showcase Preset'),
                      _buildThemeSelector(),
                      const SizedBox(height: 10),
                      _buildToggles(),

                      const SizedBox(height: 32),
                      _buildStartButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return DropdownButtonFormField<DemoThemePreset>(
      initialValue: widget.config.themePreset,
      decoration: InputDecoration(
        labelText: 'Theme Preset',
        prefixIcon: const Icon(Icons.palette_outlined, size: 20),
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: DemoThemePreset.values
          .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
          .toList(),
      onChanged: (val) {
        if (val != null) {
          widget.onConfigChanged(widget.config.copyWith(themePreset: val));
        }
      },
    );
  }

  Widget _buildToggles() {
    return Column(
      children: [
        _buildToggleItem('Show System Events', widget.config.showSystemEvents,
            (val) => widget.onConfigChanged(widget.config.copyWith(showSystemEvents: val))),
        _buildToggleItem('Enable Left Avatar', widget.config.showLeftAvatar,
            (val) => widget.onConfigChanged(widget.config.copyWith(showLeftAvatar: val))),
        _buildToggleItem('Enable Right Avatar', widget.config.showRightAvatar,
            (val) => widget.onConfigChanged(widget.config.copyWith(showRightAvatar: val))),
      ],
    );
  }

  Widget _buildToggleItem(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: const Color(0xFF34917C),
        )
      ],
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF34917C),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: initiating ? null : _onDoLogin,
        child: initiating
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Text('Launch Chat Room',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _onDoLogin() async {
    // Basic validation
    if (appIdController.text.isEmpty || channelIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('App ID and Channel ID are required')),
      );
      return;
    }

    setState(() => initiating = true);

    try {
      final qiscusMultichannel = ref.read(QMultichannel.provider);
      qiscusMultichannel.setChannelId(channelIdController.text);
      qiscusMultichannel.setUser(
        userId: usernameController.text,
        displayName: displayNameController.text,
        avatarUrl: widget.config.avatarUrl,
      );

      // Surfacing FCM issues non-fatally
      try {
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null) qiscusMultichannel.setDeviceId(token);
      } catch (e) {
        debugPrint('Got error when fetching FCM token, proceeding anyway: $e');
      }

      await FirebaseMessaging.instance.requestPermission();

      await qiscusMultichannel.initiateChat();

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(widget.config.roomTitle),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => showShowcasePanel(context),
                  )
                ],
              ),
              body: QChatRoomScreen(onBack: (ctx) {
                ref.read(QMultichannel.provider).clearUser();
                Navigator.of(context).maybePop();
              }),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error initiating chat: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => initiating = false);
    }
  }
}

