import 'package:flutter/material.dart';
 
void main() {

  runApp(const TravelReservationApp());

}
 
class TravelReservationApp extends StatelessWidget {

  const TravelReservationApp({super.key});
 
  @override

  Widget build(BuildContext context) {

    const cyberBlack = Color(0xFF080A14);

    const neonCyan = Color(0xFF00E5FF);
 
    return MaterialApp(

      title: 'Reserva de Viaje',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        useMaterial3: true,

        scaffoldBackgroundColor: cyberBlack,

        colorScheme: ColorScheme.fromSeed(

          seedColor: neonCyan,

          brightness: Brightness.dark,

          surface: const Color(0xFF12172A),

        ),

        appBarTheme: const AppBarTheme(

          backgroundColor: Color(0xFF0D1020),

          foregroundColor: neonCyan,

          centerTitle: true,

          elevation: 0,

        ),

        snackBarTheme: const SnackBarThemeData(

          backgroundColor: Color(0xFF20294A),

          contentTextStyle: TextStyle(color: Colors.white),

          behavior: SnackBarBehavior.floating,

        ),

      ),

      home: const ReservationPage(),

    );

  }

}
 
class Reservation {

  const Reservation({

    required this.name,

    required this.email,

    required this.destination,

    required this.transport,

    required this.hotel,

    required this.tour,

    required this.insurance,

    required this.notifications,

    required this.budget,

    required this.travelDate,

  });
 
  final String name;

  final String email;

  final String destination;

  final String transport;

  final bool hotel;

  final bool tour;

  final bool insurance;

  final bool notifications;

  final double budget;

  final DateTime? travelDate;
 
  int get extrasCost =>

      (hotel ? 1200 : 0) + (tour ? 600 : 0) + (insurance ? 400 : 0);
 
  String get formattedDate {

    if (travelDate == null) return 'Sin fecha seleccionada';

    return '${travelDate!.day.toString().padLeft(2, '0')}/'

        '${travelDate!.month.toString().padLeft(2, '0')}/'

        '${travelDate!.year}';

  }

}
 
class ReservationPage extends StatefulWidget {

  const ReservationPage({super.key});
 
  @override

  State<ReservationPage> createState() => _ReservationPageState();

}
 
class _ReservationPageState extends State<ReservationPage> {

  static const Color _neonCyan = Color(0xFF00E5FF);

  static const Color _neonPink = Color(0xFFFF2D95);

  static const Color _neonYellow = Color(0xFFFFD60A);

  static const Color _panel = Color(0xFF12172A);
 
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();
 
  String _destination = 'Playa';

  String _transport = 'Avion';

  bool _hotel = false;

  bool _tour = false;

  bool _insurance = false;

  bool _notifications = true;

  double _budget = 5000;

  DateTime? _travelDate;
 
  @override

  void dispose() {

    _nameController.dispose();

    _emailController.dispose();

    super.dispose();

  }
 
  void _showMessage(String message) {

    ScaffoldMessenger.of(context)

      ..hideCurrentSnackBar()

      ..showSnackBar(SnackBar(content: Text(message)));

  }
 
  void _clearReservation() {

    setState(() {

      _nameController.clear();

      _emailController.clear();

      _destination = 'Playa';

      _transport = 'Avion';

      _hotel = false;

      _tour = false;

      _insurance = false;

      _notifications = true;

      _budget = 5000;

      _travelDate = null;

    });

    _showMessage('Datos de reserva limpiados.');

  }
 
  Future<void> _pickDate() async {

    final chosenDate = await showDatePicker(

      context: context,

      initialDate: _travelDate ?? DateTime.now().add(const Duration(days: 1)),

      firstDate: DateTime.now(),

      lastDate: DateTime.now().add(const Duration(days: 730)),

      builder: (context, child) {

        return Theme(

          data: Theme.of(context).copyWith(

            colorScheme: const ColorScheme.dark(

              primary: _neonCyan,

              onPrimary: Color(0xFF071019),

              surface: _panel,

              onSurface: Colors.white,

            ),

          ),

          child: child!,

        );

      },

    );
 
    if (chosenDate == null || !mounted) return;

    setState(() => _travelDate = chosenDate);

    _showMessage('Fecha seleccionada: ${_formatDate(chosenDate)}');

  }
 
  String _formatDate(DateTime date) {

    return '${date.day.toString().padLeft(2, '0')}/'

        '${date.month.toString().padLeft(2, '0')}/${date.year}';

  }
 
  Reservation get _reservation => Reservation(

        name: _nameController.text.trim(),

        email: _emailController.text.trim(),

        destination: _destination,

        transport: _transport,

        hotel: _hotel,

        tour: _tour,

        insurance: _insurance,

        notifications: _notifications,

        budget: _budget,

        travelDate: _travelDate,

      );
 
  void _openTicket({required bool confirmed}) {

    if (confirmed) {

      _showMessage('Reserva confirmada. Preparando tu boleto...');

    }

    Navigator.of(context).push(

      MaterialPageRoute(builder: (_) => TicketPage(reservation: _reservation)),

    );

  }
 
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(

          'Reserva de Viaje',

          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2),

        ),

        actions: [

          IconButton(

            tooltip: 'Limpiar información',

            onPressed: _clearReservation,

            icon: const Icon(Icons.cleaning_services_outlined),

          ),

        ],

      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              _sectionHeader(

                number: '01',

                title: 'Seccion 1 - Informacion general',

                subtitle: 'Completa tu reserva paso a paso',

              ),

              const SizedBox(height: 10),

              const Text(

                'Llena tus datos, elige destino y confirma tu viaje.',

                style: TextStyle(color: Color(0xFFC5CBE3), height: 1.5),

              ),

              const SizedBox(height: 28),

              _sectionHeader(

                number: '02',

                title: 'Seccion 2 - Datos del viajero',

                subtitle: 'Identificacion de pasajero',

              ),

              const SizedBox(height: 14),

              _cyberTextField(

                controller: _nameController,

                label: 'Nombre completo',

                hint: 'Ej: Ana Garcia',

                icon: Icons.person_outline,

              ),

              const SizedBox(height: 14),

              _cyberTextField(

                controller: _emailController,

                label: 'Correo electronico',

                hint: 'Ej: ana@correo.com',

                icon: Icons.alternate_email,

                keyboardType: TextInputType.emailAddress,

              ),

              const SizedBox(height: 28),

              _sectionHeader(

                number: '03',

                title: 'Seccion 3 - Destino y transporte',

                subtitle: 'Selecciona la ruta que prefieras',

              ),

              const SizedBox(height: 14),

              Row(

                children: [

                  Expanded(

                    child: _destinationCard(

                      label: 'Playa',

                      icon: Icons.beach_access,

                      color: const Color(0xFF34A9FF),

                    ),

                  ),

                  const SizedBox(width: 8),

                  Expanded(

                    child: _destinationCard(

                      label: 'Ciudad',

                      icon: Icons.location_city,

                      color: const Color(0xFFFF8A3D),

                    ),

                  ),

                  const SizedBox(width: 8),

                  Expanded(

                    child: _destinationCard(

                      label: 'Montaña',

                      icon: Icons.landscape,

                      color: const Color(0xFF71E18D),

                    ),

                  ),

                ],

              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(

                value: _transport,

                dropdownColor: _panel,

                decoration: _inputDecoration(

                  label: 'Transporte',

                  hint: 'Selecciona tu transporte',

                  icon: Icons.directions_transit,

                ),

                items: const ['Avion', 'Autobus', 'Tren', 'Barco']

                    .map(

                      (transport) => DropdownMenuItem(

                        value: transport,

                        child: Text(transport),

                      ),

                    )

                    .toList(),

                onChanged: (value) {

                  if (value == null) return;

                  setState(() => _transport = value);

                  _showMessage('Transporte seleccionado: $value');

                },

              ),

              const SizedBox(height: 28),

              _sectionHeader(

                number: '04',

                title: 'Seccion 4 - Extras y preferencias',

                subtitle: 'Personaliza la experiencia',

              ),

              const SizedBox(height: 14),

              _extraTile(

                title: 'Hotel incluido',

                price: '+ \$1200',

                icon: Icons.hotel,

                active: _hotel,

                onChanged: (value) {

                  setState(() => _hotel = value);

                  _showMessage(value ? 'Hotel agregado.' : 'Hotel eliminado.');

                },

              ),

              const SizedBox(height: 9),

              _extraTile(

                title: 'Tour guiado',

                price: '+ \$600',

                icon: Icons.tour,

                active: _tour,

                onChanged: (value) {

                  setState(() => _tour = value);

                  _showMessage(value ? 'Tour agregado.' : 'Tour eliminado.');

                },

              ),

              const SizedBox(height: 9),

              _extraTile(

                title: 'Seguro de viaje',

                price: '+ \$400',

                icon: Icons.health_and_safety,

                active: _insurance,

                onChanged: (value) {

                  setState(() => _insurance = value);

                  _showMessage(value ? 'Seguro agregado.' : 'Seguro eliminado.');

                },

              ),

              const SizedBox(height: 12),

              Container(

                decoration: BoxDecoration(

                  color: _notifications

                      ? _neonCyan.withOpacity(0.12)

                      : _panel,

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(

                    color: _notifications ? _neonCyan : const Color(0xFF37415F),

                  ),

                ),

                child: SwitchListTile(

                  secondary: const Icon(Icons.notifications_active_outlined),

                  title: const Text('Recibir notificaciones'),

                  subtitle: Text(

                    _notifications ? 'Activadas' : 'Desactivadas',

                    style: TextStyle(

                      color: _notifications ? _neonCyan : const Color(0xFFB5BCD0),

                    ),

                  ),

                  value: _notifications,

                  activeColor: _neonCyan,

                  onChanged: (value) {

                    setState(() => _notifications = value);

                    _showMessage(

                      value ? 'Notificaciones activadas.' : 'Notificaciones desactivadas.',

                    );

                  },

                ),

              ),

              const SizedBox(height: 20),

              Container(

                padding: const EdgeInsets.fromLTRB(16, 15, 16, 10),

                decoration: BoxDecoration(

                  color: _panel,

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(color: const Color(0xFF37415F)),

                ),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        const Text(

                          'Presupuesto:',

                          style: TextStyle(fontWeight: FontWeight.w700),

                        ),

                        Text(

                          '\$${_budget.toStringAsFixed(0)}',

                          style: const TextStyle(

                            color: _neonYellow,

                            fontWeight: FontWeight.w900,

                            letterSpacing: 0.8,

                          ),

                        ),

                      ],

                    ),

                    Slider(

                      value: _budget,

                      min: 500,

                      max: 10000,

                      divisions: 20,

                      activeColor: _neonPink,

                      inactiveColor: const Color(0xFF343D5C),

                      label: '\$${_budget.toStringAsFixed(0)}',

                      onChanged: (value) => setState(() => _budget = value),

                    ),

                    const Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text('\$500', style: TextStyle(color: Color(0xFF9DA7C5))),

                        Text('\$10000', style: TextStyle(color: Color(0xFF9DA7C5))),

                      ],

                    ),

                  ],

                ),

              ),

              const SizedBox(height: 12),

              InkWell(

                borderRadius: BorderRadius.circular(14),

                onTap: _pickDate,

                child: Container(

                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(

                    color: _panel,

                    borderRadius: BorderRadius.circular(14),

                    border: Border.all(color: const Color(0xFF37415F)),

                  ),

                  child: Row(

                    children: [

                      const Icon(Icons.calendar_month, color: _neonCyan),

                      const SizedBox(width: 14),

                      Expanded(

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            const Text(

                              'Fecha del viaje',

                              style: TextStyle(fontWeight: FontWeight.w700),

                            ),

                            const SizedBox(height: 3),

                            Text(

                              _travelDate == null

                                  ? 'Toca para elegir fecha'

                                  : _formatDate(_travelDate!),

                              style: TextStyle(

                                color: _travelDate == null

                                    ? const Color(0xFF9DA7C5)

                                    : _neonCyan,

                              ),

                            ),

                          ],

                        ),

                      ),

                      const Icon(Icons.chevron_right, color: Color(0xFF9DA7C5)),

                    ],

                  ),

                ),

              ),

              const SizedBox(height: 28),

              _sectionHeader(

                number: '05',

                title: 'Seccion 5 - Confirmar',

                subtitle: 'Revisa tus datos antes de despegar',

              ),

              const SizedBox(height: 16),

              Row(

                children: [

                  Expanded(

                    child: OutlinedButton.icon(

                      onPressed: () => _openTicket(confirmed: false),

                      icon: const Icon(Icons.visibility_outlined),

                      label: const Text('Ver Resumen'),

                      style: OutlinedButton.styleFrom(

                        foregroundColor: _neonCyan,

                        side: const BorderSide(color: _neonCyan),

                        padding: const EdgeInsets.symmetric(vertical: 15),

                      ),

                    ),

                  ),

                  const SizedBox(width: 12),

                  Expanded(

                    child: FilledButton.icon(

                      onPressed: () => _openTicket(confirmed: true),

                      icon: const Icon(Icons.flight_takeoff),

                      label: const Text('Confirmar'),

                      style: FilledButton.styleFrom(

                        backgroundColor: _neonPink,

                        foregroundColor: Colors.white,

                        padding: const EdgeInsets.symmetric(vertical: 15),

                      ),

                    ),

                  ),

                ],

              ),

            ],

          ),

        ),

      ),

    );

  }
 
  Widget _sectionHeader({

    required String number,

    required String title,

    required String subtitle,

  }) {

    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Container(

          width: 40,

          height: 40,

          alignment: Alignment.center,

          decoration: BoxDecoration(

            color: _neonPink.withOpacity(0.16),

            border: Border.all(color: _neonPink),

            borderRadius: BorderRadius.circular(8),

          ),

          child: Text(

            number,

            style: const TextStyle(

              color: _neonPink,

              fontWeight: FontWeight.w900,

              letterSpacing: 1,

            ),

          ),

        ),

        const SizedBox(width: 11),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                title,

                style: const TextStyle(

                  color: Colors.white,

                  fontWeight: FontWeight.w800,

                  fontSize: 16,

                ),

              ),

              const SizedBox(height: 3),

              Text(

                subtitle,

                style: const TextStyle(color: Color(0xFF9DA7C5), fontSize: 12),

              ),

            ],

          ),

        ),

      ],

    );

  }
 
  Widget _cyberTextField({

    required TextEditingController controller,

    required String label,

    required String hint,

    required IconData icon,

    TextInputType? keyboardType,

  }) {

    return TextField(

      controller: controller,

      keyboardType: keyboardType,

      style: const TextStyle(color: Colors.white),

      decoration: _inputDecoration(label: label, hint: hint, icon: icon),

    );

  }
 
  InputDecoration _inputDecoration({

    required String label,

    required String hint,

    required IconData icon,

  }) {

    const outline = OutlineInputBorder(

      borderRadius: BorderRadius.all(Radius.circular(12)),

      borderSide: BorderSide(color: Color(0xFF37415F)),

    );

    return InputDecoration(

      labelText: label,

      hintText: hint,

      labelStyle: const TextStyle(color: _neonCyan),

      hintStyle: const TextStyle(color: Color(0xFF808AA9)),

      prefixIcon: Icon(icon, color: _neonCyan),

      filled: true,

      fillColor: _panel,

      enabledBorder: outline,

      focusedBorder: const OutlineInputBorder(

        borderRadius: BorderRadius.all(Radius.circular(12)),

        borderSide: BorderSide(color: _neonCyan, width: 1.6),

      ),

    );

  }
 
  Widget _destinationCard({

    required String label,

    required IconData icon,

    required Color color,

  }) {

    final isSelected = _destination == label;

    return InkWell(

      borderRadius: BorderRadius.circular(12),

      onTap: () {

        setState(() => _destination = label);

        _showMessage('Destino seleccionado: $label');

      },

      child: AnimatedContainer(

        duration: const Duration(milliseconds: 180),

        height: 108,

        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(

          color: isSelected ? color.withOpacity(0.18) : _panel,

          borderRadius: BorderRadius.circular(12),

          border: Border.all(color: isSelected ? color : const Color(0xFF37415F)),

          boxShadow: isSelected

              ? [BoxShadow(color: color.withOpacity(0.20), blurRadius: 12)]

              : null,

        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(icon, color: color, size: 30),

            const SizedBox(height: 9),

            Text(

              label,

              textAlign: TextAlign.center,

              style: TextStyle(

                color: isSelected ? color : Colors.white,

                fontSize: 12,

                fontWeight: FontWeight.w800,

              ),

            ),

          ],

        ),

      ),

    );

  }
 
  Widget _extraTile({

    required String title,

    required String price,

    required IconData icon,

    required bool active,

    required ValueChanged<bool> onChanged,

  }) {

    return Container(

      decoration: BoxDecoration(

        color: active ? _neonYellow.withOpacity(0.12) : _panel,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(

          color: active ? _neonYellow : const Color(0xFF37415F),

        ),

      ),

      child: CheckboxListTile(

        value: active,

        onChanged: (value) => onChanged(value ?? false),

        activeColor: _neonYellow,

        checkColor: const Color(0xFF16120A),

        secondary: Icon(icon, color: active ? _neonYellow : _neonCyan),

        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),

        subtitle: Text(price, style: const TextStyle(color: Color(0xFFB5BCD0))),

        controlAffinity: ListTileControlAffinity.trailing,

      ),

    );

  }

}
 
class TicketPage extends StatelessWidget {

  const TicketPage({super.key, required this.reservation});
 
  static const Color _neonCyan = Color(0xFF00E5FF);

  static const Color _neonPink = Color(0xFFFF2D95);
 
  final Reservation reservation;
 
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text('Mi Boleto')),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(18),

          child: Column(

            children: [

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(

                  color: const Color(0xFF12172A),

                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(color: _neonCyan, width: 1.2),

                  boxShadow: [

                    BoxShadow(color: _neonCyan.withOpacity(0.14), blurRadius: 22),

                  ],

                ),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text(

                          'NEON AIRLINES',

                          style: TextStyle(

                            color: _neonCyan,

                            fontWeight: FontWeight.w900,

                            letterSpacing: 1.5,

                          ),

                        ),

                        Icon(Icons.qr_code_2, color: _neonPink, size: 30),

                      ],

                    ),

                    const Padding(

                      padding: EdgeInsets.symmetric(vertical: 18),

                      child: Divider(color: Color(0xFF394463)),

                    ),

                    Text(

                      reservation.destination.toUpperCase(),

                      style: const TextStyle(

                        color: Colors.white,

                        fontSize: 31,

                        fontWeight: FontWeight.w900,

                        letterSpacing: 1.1,

                      ),

                    ),

                    const SizedBox(height: 4),

                    Text(

                      'Salida programada: ${reservation.formattedDate}',

                      style: const TextStyle(color: Color(0xFFB5BCD0)),

                    ),

                    const SizedBox(height: 20),

                    _ticketRow('Pasajero', reservation.name.isEmpty ? 'Sin registrar' : reservation.name),

                    _ticketRow('Correo', reservation.email.isEmpty ? 'Sin registrar' : reservation.email),

                    _ticketRow('Transporte', reservation.transport),

                    _ticketRow('Presupuesto', '\$${reservation.budget.toStringAsFixed(0)}'),

                    _ticketRow('Extras', '\$${reservation.extrasCost}'),

                    _ticketRow(

                      'Notificaciones',

                      reservation.notifications ? 'Activadas' : 'Desactivadas',

                    ),

                    const SizedBox(height: 18),

                    const Text(

                      'EXTRAS ACTIVOS',

                      style: TextStyle(

                        color: _neonPink,

                        fontSize: 12,

                        fontWeight: FontWeight.w900,

                        letterSpacing: 1.2,

                      ),

                    ),

                    const SizedBox(height: 8),

                    Wrap(

                      spacing: 7,

                      runSpacing: 7,

                      children: [

                        _extraChip('Hotel', reservation.hotel),

                        _extraChip('Tour', reservation.tour),

                        _extraChip('Seguro', reservation.insurance),

                      ],

                    ),

                  ],

                ),

              ),

              const SizedBox(height: 24),

              SizedBox(

                width: double.infinity,

                child: OutlinedButton.icon(

                  onPressed: () => Navigator.of(context).pop(),

                  icon: const Icon(Icons.arrow_back),

                  label: const Text('Regresar'),

                  style: OutlinedButton.styleFrom(

                    foregroundColor: _neonCyan,

                    side: const BorderSide(color: _neonCyan),

                    padding: const EdgeInsets.symmetric(vertical: 15),

                  ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }
 
  Widget _ticketRow(String label, String value) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 10),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          SizedBox(

            width: 110,

            child: Text(label, style: const TextStyle(color: Color(0xFF9DA7C5))),

          ),

          Expanded(

            child: Text(

              value,

              textAlign: TextAlign.right,

              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),

            ),

          ),

        ],

      ),

    );

  }
 
  Widget _extraChip(String label, bool enabled) {

    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

      decoration: BoxDecoration(

        color: enabled ? _neonPink.withOpacity(0.16) : const Color(0xFF252B40),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(

          color: enabled ? _neonPink : const Color(0xFF4A536D),

        ),

      ),

      child: Text(

        '$label: ${enabled ? 'Si' : 'No'}',

        style: TextStyle(

          color: enabled ? _neonPink : const Color(0xFF9DA7C5),

          fontSize: 12,

          fontWeight: FontWeight.w700,

        ),

      ),

    );

  }

}

 