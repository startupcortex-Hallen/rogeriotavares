import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// LOGIN DO PAINEL ADMIN (Supabase Auth + admin_users).
class AdminLoginPage extends ConsumerStatefulWidget {
  const AdminLoginPage({super.key});

  @override
  ConsumerState<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends ConsumerState<AdminLoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _email.text.trim();
    final password = _password.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe email e senha.')),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      await ref
          .read(supabaseProvider)
          .auth
          .signInWithPassword(email: email, password: password);
      // verifica papel administrativo
      final profile = await ref.read(engagementRepositoryProvider).fetchProfileByEmail(email);
      final adminRows = await ref
          .read(supabaseProvider)
          .from('admin_users')
          .select('email, is_active')
          .eq('email', email)
          .limit(1);
      final allowed = profile != null &&
          (profile.isAdmin || profile.isEditor || profile.isModerator) &&
          profile.isActive &&
          (adminRows.isEmpty || adminRows.first['is_active'] == true);

      if (!allowed && mounted) {
        await ref.read(supabaseProvider).auth.signOut();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Acesso não autorizado para o painel.')),
          );
        }
        return;
      }
      if (mounted) context.go('/admin');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível entrar. Verifique as credenciais.')),
        );
      }
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Scaffold(
      backgroundColor: p.primary,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(RtSpace.lg),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(RtSpace.xl),
            decoration: BoxDecoration(
              color: p.surface,
              borderRadius: BorderRadius.circular(RtRadius.xxl),
              boxShadow: [RtShadow.lg()],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const RtAvatar(size: 72),
                const SizedBox(height: RtSpace.md),
                Text('Painel Administrativo',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('Rogério Tavares 45788',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: p.primary)),
                const SizedBox(height: RtSpace.sm),
                Text('Acesso restrito à equipe autorizada da campanha.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                const SizedBox(height: RtSpace.lg),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: RtSpace.md),
                TextField(
                  controller: _password,
                  obscureText: _obscure,
                  onSubmitted: (_) => _login(),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: RtSpace.lg),
                RtButton(
                  label: 'Entrar no painel',
                  size: 'large',
                  icon: Icons.login_rounded,
                  loading: _loading,
                  onPressed: _login,
                ),
                const SizedBox(height: RtSpace.sm),
                TextButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Voltar para o site oficial'),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}