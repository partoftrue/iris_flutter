import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Employee';
  bool _isLoading = false;
  bool _obscurePassword = true;
  int _currentStep = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final Map<int, bool> _fieldFocusStates = {
    0: false, // First name
    1: false, // Last name
    2: false, // Email
    3: false, // Password
  };
  String? _suggestedEmail;
  final List<String> _emailDomains = ['@gmail.com', '@naver.com', '@kakao.com'];
  bool _isCurrentStepValid = false;
  final Map<int, String?> _fieldErrors = {
    0: null, // First name
    1: null, // Last name
    2: null, // Email
    3: null, // Password
  };
  final Map<int, FocusNode> _focusNodes = {
    0: FocusNode(), // First name
    1: FocusNode(), // Last name
    2: FocusNode(), // Email
    3: FocusNode(), // Password
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _animationController.forward();
    _emailController.addListener(_updateEmailSuggestion);
    _firstNameController.addListener(_validateCurrentStep);
    _lastNameController.addListener(_validateCurrentStep);
    _emailController.addListener(_validateCurrentStep);
    _passwordController.addListener(_validateCurrentStep);
    _focusNodes.forEach((_, node) {
      node.addListener(() {
        setState(() {
          _fieldFocusStates[_focusNodes.keys.firstWhere((key) => _focusNodes[key] == node)] = node.hasFocus;
        });
      });
    });
  }

  void _updateEmailSuggestion() {
    final text = _emailController.text;
    if (text.isNotEmpty && !text.contains('@')) {
      setState(() {
        _suggestedEmail = text + _emailDomains[0];
      });
    } else {
      setState(() {
        _suggestedEmail = null;
      });
    }
  }

  void _applySuggestion() {
    if (_suggestedEmail != null) {
      _emailController.text = _suggestedEmail!;
      _emailController.selection = TextSelection.fromPosition(
        TextPosition(offset: _suggestedEmail!.length),
      );
    }
  }

  void _validateField(int fieldIndex, String? value) {
    setState(() {
      switch (fieldIndex) {
        case 0: // First name
          if (value == null || value.isEmpty) {
            _fieldErrors[0] = 'Please enter your first name';
          } else {
            _fieldErrors[0] = null;
          }
          break;
        case 1: // Last name
          if (value == null || value.isEmpty) {
            _fieldErrors[1] = 'Please enter your last name';
          } else {
            _fieldErrors[1] = null;
          }
          break;
        case 2: // Email
          if (value == null || value.isEmpty) {
            _fieldErrors[2] = 'Please enter your email address';
          } else if (!value.contains('@')) {
            _fieldErrors[2] = 'Please enter a valid email address';
          } else {
            _fieldErrors[2] = null;
          }
          break;
        case 3: // Password
          if (value == null || value.isEmpty) {
            _fieldErrors[3] = 'Please enter your password';
          } else if (value.length < 6) {
            _fieldErrors[3] = 'Password must be at least 6 characters';
          } else {
            _fieldErrors[3] = null;
          }
          break;
      }
    });
    _validateCurrentStep();
  }

  void _validateCurrentStep() {
    setState(() {
      switch (_currentStep) {
        case 0:
          _isCurrentStepValid = _firstNameController.text.isNotEmpty &&
              _lastNameController.text.isNotEmpty;
          break;
        case 1:
          _isCurrentStepValid = _emailController.text.isNotEmpty &&
              _emailController.text.contains('@') &&
              _passwordController.text.length >= 6;
          break;
        case 2:
          _isCurrentStepValid = true; // Role is always selected
          break;
        default:
          _isCurrentStepValid = false;
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    _emailController.removeListener(_updateEmailSuggestion);
    _firstNameController.removeListener(_validateCurrentStep);
    _lastNameController.removeListener(_validateCurrentStep);
    _emailController.removeListener(_validateCurrentStep);
    _passwordController.removeListener(_validateCurrentStep);
    _focusNodes.forEach((_, node) => node.dispose());
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await context.read<AuthProvider>().register({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'role': _selectedRole,
        });
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        if (mounted) {
          final errorMessage = e.toString();
          String title;
          String message;
          IconData icon;

          if (errorMessage.contains('email already exists')) {
            title = 'Email Already Registered';
            message = 'This email address is already in use. Please try signing in or use a different email.';
            icon = Icons.email_outlined;
          } else if (errorMessage.contains('network')) {
            title = 'Connection Error';
            message = 'Please check your internet connection and try again.';
            icon = Icons.wifi_off_outlined;
          } else {
            title = 'Registration Failed';
            message = 'We\'re having trouble creating your account. Please try again later.';
            icon = Icons.error_outline;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Theme.of(context).colorScheme.error,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            message,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: colorScheme.onBackground,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Create Account',
                        style: textTheme.displayLarge?.copyWith(
                          color: colorScheme.onBackground,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Join us and start managing your work schedule efficiently',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onBackground.withOpacity(0.7),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      Stepper(
                        currentStep: _currentStep,
                        onStepContinue: () {
                          if (_currentStep < 2) {
                            setState(() => _currentStep++);
                          } else {
                            _register();
                          }
                        },
                        onStepCancel: () {
                          if (_currentStep > 0) {
                            setState(() => _currentStep--);
                          }
                        },
                        controlsBuilder: (context, details) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Row(
                              children: [
                                if (_currentStep > 0)
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: details.onStepCancel,
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: const Text('Back'),
                                    ),
                                  ),
                                if (_currentStep > 0)
                                  const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _isCurrentStepValid && !_isLoading
                                        ? details.onStepContinue
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.onPrimary,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      disabledBackgroundColor:
                                          colorScheme.primary.withOpacity(0.3),
                                    ),
                                    child: _isLoading
                                        ? SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                colorScheme.onPrimary,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            _currentStep == 2 ? 'Create Account' : 'Continue',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        steps: [
                          Step(
                            title: const Text('Personal Information'),
                            content: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: _fieldFocusStates[0]!
                                        ? [
                                            BoxShadow(
                                              color: colorScheme.primary.withOpacity(0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    focusNode: _focusNodes[0],
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: colorScheme.onBackground,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      hintText: 'Enter your first name',
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: _fieldFocusStates[0]!
                                            ? colorScheme.primary
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: colorScheme.outline.withOpacity(0.5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: colorScheme.primary,
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: _fieldFocusStates[0]!
                                          ? colorScheme.primary.withOpacity(0.05)
                                          : colorScheme.surface,
                                    ),
                                    onChanged: (value) => _validateField(0, value),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: _fieldFocusStates[1]!
                                        ? [
                                            BoxShadow(
                                              color: colorScheme.primary.withOpacity(0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    focusNode: _focusNodes[1],
                                    textInputAction: TextInputAction.next,
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: colorScheme.onBackground,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      hintText: 'Enter your last name',
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: _fieldFocusStates[1]!
                                            ? colorScheme.primary
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: colorScheme.outline.withOpacity(0.5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: colorScheme.primary,
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: _fieldFocusStates[1]!
                                          ? colorScheme.primary.withOpacity(0.05)
                                          : colorScheme.surface,
                                    ),
                                    onChanged: (value) => _validateField(1, value),
                                  ),
                                ),
                              ],
                            ),
                            isActive: _currentStep >= 0,
                          ),
                          Step(
                            title: const Text('Account Details'),
                            content: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: _fieldFocusStates[2]!
                                        ? [
                                            BoxShadow(
                                              color: colorScheme.primary.withOpacity(0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: _emailController,
                                        focusNode: _focusNodes[2],
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        style: textTheme.bodyLarge?.copyWith(
                                          color: colorScheme.onBackground,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          hintText: 'Enter your email',
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color: _fieldFocusStates[2]!
                                                ? colorScheme.primary
                                                : colorScheme.onSurfaceVariant,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: colorScheme.outline.withOpacity(0.5),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: colorScheme.primary,
                                              width: 2,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: _fieldFocusStates[2]!
                                              ? colorScheme.primary.withOpacity(0.05)
                                              : colorScheme.surface,
                                        ),
                                        onChanged: (value) => _validateField(2, value),
                                      ),
                                      if (_suggestedEmail != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 8,
                                          ),
                                          child: GestureDetector(
                                            onTap: _applySuggestion,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: colorScheme.primary.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    _suggestedEmail!,
                                                    style: textTheme.bodyMedium?.copyWith(
                                                      color: colorScheme.primary,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    size: 16,
                                                    color: colorScheme.primary,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: _fieldFocusStates[3]!
                                        ? [
                                            BoxShadow(
                                              color: colorScheme.primary.withOpacity(0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    focusNode: _focusNodes[3],
                                    obscureText: _obscurePassword,
                                    textInputAction: TextInputAction.done,
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: colorScheme.onBackground,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: 'Enter your password',
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: _fieldFocusStates[3]!
                                            ? colorScheme.primary
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: _fieldFocusStates[3]!
                                              ? colorScheme.primary
                                              : colorScheme.onSurfaceVariant,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword = !_obscurePassword;
                                          });
                                        },
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: colorScheme.outline.withOpacity(0.5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: colorScheme.primary,
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: _fieldFocusStates[3]!
                                          ? colorScheme.primary.withOpacity(0.05)
                                          : colorScheme.surface,
                                    ),
                                    onChanged: (value) => _validateField(3, value),
                                  ),
                                ),
                              ],
                            ),
                            isActive: _currentStep >= 1,
                          ),
                          Step(
                            title: const Text('Role Selection'),
                            content: Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(
                                      color: colorScheme.outline.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      RadioListTile<String>(
                                        title: const Text('Employee'),
                                        subtitle: const Text(
                                          'I want to manage my work schedule and requests',
                                        ),
                                        value: 'Employee',
                                        groupValue: _selectedRole,
                                        onChanged: (value) {
                                          setState(() => _selectedRole = value!);
                                        },
                                        activeColor: colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      const Divider(height: 1),
                                      RadioListTile<String>(
                                        title: const Text('Employer'),
                                        subtitle: const Text(
                                          'I want to manage employees and their schedules',
                                        ),
                                        value: 'Employer',
                                        groupValue: _selectedRole,
                                        onChanged: (value) {
                                          setState(() => _selectedRole = value!);
                                        },
                                        activeColor: colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            isActive: _currentStep >= 2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onBackground.withOpacity(0.7),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: colorScheme.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
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
} 