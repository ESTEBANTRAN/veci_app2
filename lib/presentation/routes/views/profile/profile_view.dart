import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../bloc/controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipController;
  late TextEditingController _countryController;
  late TextEditingController _houseNumberController;

  final ProfileController profileController = Get.put(ProfileController());
  bool _isLoading = true;
  bool _hasChanges = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Inicializar controladores
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _zipController = TextEditingController();
    _countryController = TextEditingController();
    _houseNumberController = TextEditingController();

    // Cargar datos del perfil
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    await profileController.loadProfile();
    setState(() {
      _nameController.text = profileController.name.value;
      _emailController.text = profileController.email.value;
      _addressController.text = profileController.address.value;
      _phoneController.text = profileController.phone.value;
      _cityController.text = profileController.city.value;
      _stateController.text = profileController.state.value;
      _zipController.text = profileController.zip.value;
      _countryController.text = profileController.country.value;
      _houseNumberController.text = profileController.houseNumber.value;
      _selectedDate = profileController.birthDate.value;
      _isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'ES'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _hasChanges = true;
      });
    }
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    _houseNumberController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    // Mostrar diálogo de confirmación
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Cambios'),
        content: const Text(
          '¿Estás seguro de que quieres guardar los cambios?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);

    await profileController.updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      zip: _zipController.text.trim(),
      country: _countryController.text.trim(),
      houseNumber: _houseNumberController.text.trim(),
      birthDate: _selectedDate,
    );

    setState(() {
      _isLoading = false;
      _hasChanges = false;
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        onChanged: (_) => _onFieldChanged(),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Fecha de Nacimiento',
            prefixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          child: Text(
            _selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : 'Seleccionar fecha',
            style: TextStyle(
              color: _selectedDate != null ? Colors.black : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          if (_hasChanges)
            TextButton(
              onPressed: _saveProfile,
              child: const Text(
                'Guardar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información Personal
              const Text(
                'Información Personal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _nameController,
                label: 'Nombre',
                icon: Icons.person,
              ),

              _buildTextField(
                controller: _emailController,
                label: 'Correo electrónico',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              _buildTextField(
                controller: _phoneController,
                label: 'Teléfono',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              _buildDateField(),

              const SizedBox(height: 24),

              // Información de Dirección
              const Text(
                'Información de Dirección',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _addressController,
                label: 'Dirección',
                icon: Icons.home,
              ),

              _buildTextField(
                controller: _houseNumberController,
                label: 'Número de Casa',
                icon: Icons.home_work,
              ),

              _buildTextField(
                controller: _cityController,
                label: 'Ciudad',
                icon: Icons.location_city,
              ),

              _buildTextField(
                controller: _stateController,
                label: 'Provincia/Estado',
                icon: Icons.map,
              ),

              _buildTextField(
                controller: _zipController,
                label: 'Código Postal',
                icon: Icons.pin_drop,
                keyboardType: TextInputType.number,
              ),

              _buildTextField(
                controller: _countryController,
                label: 'País',
                icon: Icons.public,
              ),

              const SizedBox(height: 32),

              // Botón de guardar principal
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _hasChanges ? _saveProfile : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Guardar Cambios',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Información adicional
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Todos los campos son opcionales\n'
                      '• Los cambios se guardarán en tu perfil\n'
                      '• Puedes modificar cualquier campo en cualquier momento',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
