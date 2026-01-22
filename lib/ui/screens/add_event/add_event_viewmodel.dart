import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class TicketTier {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController seatsController;

  TicketTier({
    required this.nameController,
    required this.priceController,
    required this.seatsController,
  });
}

class AddEventViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  bool autoValidate = false;

  // Controllers
  final eventNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final venueNameController = TextEditingController();
  final venueAddressController = TextEditingController();

  // Category
  final List<String> categories = ['Dance', 'Music', 'Festival', 'Ritual'];
  String? selectedCategory;
  String? categoryError;

  // Dynamic ticket tiers
  List<TicketTier> tiers = [];

  // Start Date & Time
  DateTime? selectedStartDate;
  TimeOfDay? selectedStartTime;
  String? startDateText;
  String? startTimeText;
  String? startDateError;
  String? startTimeError;

  // End Date & Time
  DateTime? selectedEndDate;
  TimeOfDay? selectedEndTime;
  String? endDateText;
  String? endTimeText;
  String? endDateError;
  String? endTimeError;

  // Image
  final ImagePicker _picker = ImagePicker();
  File? eventImage;
  String? selectedImageName;
  String? imageError;

  // Organizer details
  String organizerId = '';
  String organizerName = '';

  // Simple animation states
  double imageScale = 1.0;
  bool showAddTier = true;

  DateTime get startDateTime => DateTime(
    selectedStartDate!.year,
    selectedStartDate!.month,
    selectedStartDate!.day,
    selectedStartTime!.hour,
    selectedStartTime!.minute,
  );

  DateTime get endDateTime => DateTime(
    selectedEndDate!.year,
    selectedEndDate!.month,
    selectedEndDate!.day,
    selectedEndTime!.hour,
    selectedEndTime!.minute,
  );

  void initialise() {
    // start with 2 tiers (General + VIP style)
    tiers = [
      TicketTier(
        nameController: TextEditingController(),
        priceController: TextEditingController(),
        seatsController: TextEditingController(),
      ),
      TicketTier(
        nameController: TextEditingController(),
        priceController: TextEditingController(),
        seatsController: TextEditingController(),
      ),
    ];

    fetchorganizer();
    notifyListeners();
  }

  // organized by
  Future<void> fetchorganizer() async {
    setBusy(true);
    final user = FirebaseAuth.instance.currentUser!;
    organizerId = user.uid;

    final profile = await userservice.getCurrentUserProfile();
    organizerName = profile['name'] ?? 'User';

    setBusy(false);
    notifyListeners();
  }

  //Image tap animation
  void onImageTapDown() {
    imageScale = 0.97;
    notifyListeners();
  }

  void onImageTapCancel() {
    imageScale = 1.0;
    notifyListeners();
  }

  void onImageTapUp() {
    imageScale = 1.0;
    notifyListeners();
    pickImage();
  }

  Future<void> pickImage() async {
    imageError = null;
    notifyListeners();

    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final file = File(picked.path);
    final bytes = await file.length();

    final ext = picked.path.split('.').last.toLowerCase();
    if (!(ext == 'jpg' || ext == 'jpeg' || ext == 'png')) {
      imageError = 'Please select a JPG or PNG image.';
      eventImage = null;
      selectedImageName = null;
      notifyListeners();
      return;
    }

    const maxBytes = 5 * 1024 * 1024;
    if (bytes > maxBytes) {
      imageError = 'Image too large. Max size is 5 MB.';
      eventImage = null;
      selectedImageName = null;
      notifyListeners();
      return;
    }

    eventImage = file;
    selectedImageName = _shortenName(picked.name);
    imageError = null;
    notifyListeners();
  }

  String _shortenName(String input, {int max = 28}) {
    if (input.length <= max) return input;
    final ext = input.split('.').last;
    return '${input.substring(0, max - ext.length - 3)}...$ext';
  }

  //Start Date & Time pickers
  Future<void> pickStartDate(BuildContext context) async {
    startDateError = null;
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 3),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFF8A3D),
              surface: Color(0xFF050304),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      selectedStartDate = result;
      startDateText =
          '${result.day.toString().padLeft(2, '0')}/${result.month.toString().padLeft(2, '0')}/${result.year}';
      selectedEndDate = null;
      endDateText = null;
      notifyListeners();
    }
  }

  Future<void> pickStartTime(BuildContext context) async {
    startTimeError = null;
    final result = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFF8A3D),
              surface: Color(0xFF050304),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      selectedStartTime = result;
      final hour = result.hourOfPeriod == 0 ? 12 : result.hourOfPeriod;
      final period = result.period == DayPeriod.am ? 'AM' : 'PM';
      startTimeText =
          '${hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')} $period';
      notifyListeners();
    }
  }

  // End Date & Time pickers
  Future<void> pickEndDate(BuildContext context) async {
    endDateError = null;
    final minDate = selectedStartDate ?? DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? minDate.add(const Duration(days: 1)),
      firstDate: minDate,
      lastDate: DateTime(minDate.year + 3),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFF8A3D),
              surface: Color(0xFF050304),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      selectedEndDate = result;
      endDateText =
          '${result.day.toString().padLeft(2, '0')}/${result.month.toString().padLeft(2, '0')}/${result.year}';
      notifyListeners();
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    endTimeError = null;
    final result = await showTimePicker(
      context: context,
      initialTime: selectedEndTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFF8A3D),
              surface: Color(0xFF050304),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      selectedEndTime = result;
      final hour = result.hourOfPeriod == 0 ? 12 : result.hourOfPeriod;
      final period = result.period == DayPeriod.am ? 'AM' : 'PM';
      endTimeText =
          '${hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')} $period';
      notifyListeners();
    }
  }

  bool _validateCategory() {
    if (selectedCategory == null) {
      categoryError = 'Please select a category.';
      notifyListeners();
      return false;
    }
    categoryError = null;
    notifyListeners();
    return true;
  }

  // ------------ Text validations ------------
  String? validateEventName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Event name is required.';
    }
    if (value.trim().length < 3) {
      return 'Event name must be at least 3 characters.';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required.';
    }
    if (value.trim().length < 100) {
      return 'Please provide at least 100 characters.';
    }
    return null;
  }

  String? validateVenueName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Venue name is required.';
    }
    return null;
  }

  String? validateVenueAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Venue address or map link is required.';
    }
    if (value.trim().length < 10) {
      return 'Please enter a more detailed address.';
    }
    return null;
  }

  String? validateTierName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tier name is required.';
    }
    return null;
  }

  String? validateTierPrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required.';
    }
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return 'Enter a valid positive price.';
    }
    return null;
  }

  String? validateTierSeats(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Seats are required.';
    }
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return 'Enter a valid positive seat count.';
    }
    return null;
  }

  bool _validateImage() {
    if (eventImage == null) {
      imageError = 'Event image is required.';
      notifyListeners();
      return false;
    }
    imageError = null;
    notifyListeners();
    return true;
  }

  bool _validateDateTime() {
    bool valid = true;

    if (selectedStartDate == null) {
      startDateError = 'Please select a start date.';
      valid = false;
    } else {
      startDateError = null;
    }

    if (selectedStartTime == null) {
      startTimeError = 'Please select a start time.';
      valid = false;
    } else {
      startTimeError = null;
    }

    if (selectedEndDate == null) {
      endDateError = 'Please select an end date.';
      valid = false;
    } else {
      endDateError = null;
    }

    if (selectedEndTime == null) {
      endTimeError = 'Please select an end time.';
      valid = false;
    } else {
      endTimeError = null;
    }

    if (selectedStartDate != null && selectedEndDate != null) {
      if (selectedEndDate!.isBefore(selectedStartDate!)) {
        endDateError = 'End date must be after start date.';
        valid = false;
      }
    }

    notifyListeners();
    return valid;
  }

  bool _validateTiers() {
    for (final t in tiers) {
      if (validateTierName(t.nameController.text) != null ||
          validateTierPrice(t.priceController.text) != null ||
          validateTierSeats(t.seatsController.text) != null) {
        return false;
      }
    }
    return true;
  }

  //Tier actions
  void addTier() {
    tiers.add(
      TicketTier(
        nameController: TextEditingController(),
        priceController: TextEditingController(),
        seatsController: TextEditingController(),
      ),
    );
    notifyListeners();
  }

  void removeTier(int index) {
    if (tiers.length <= 1) return;
    tiers[index].nameController.dispose();
    tiers[index].priceController.dispose();
    tiers[index].seatsController.dispose();
    tiers.removeAt(index);
    notifyListeners();
  }

  void onAddAnotherTier() => addTier();

  //convert ticket tier into List<Map>
  List<Map<String, dynamic>> _buildTicketList() {
    return tiers.map((t) {
      final name = t.nameController.text.trim().toLowerCase();

      return {
        'id': name.toLowerCase(), // used for booking
        'name': name.toUpperCase(), // display
        'price': double.parse(t.priceController.text),
        'totalSeats': int.parse(t.seatsController.text),
        'soldSeats': 0,
      };
    }).toList();
  }

  //Submit
  Future<void> onCreateEvent(BuildContext context) async {
    autoValidate = true;
    notifyListeners();

    final formValid = formKey.currentState?.validate() ?? false;
    final tiersValid = _validateTiers();
    final imageValid = _validateImage();
    final dateTimeValid = _validateDateTime();
    final categoryValid = _validateCategory();

    if (!formValid ||
        !tiersValid ||
        !imageValid ||
        !dateTimeValid ||
        !categoryValid) {
      return;
    }

    setBusy(true);

    try {
      final imageurl = await cloudinaryservice.uploadImage(eventImage!);

      await eventservice.createEvent(
        title: eventNameController.text.trim(),
        description: descriptionController.text.trim(),
        category: selectedCategory!,
        imageUrl: imageurl,
        organizerId: organizerId,
        organizerName: organizerName,
        venueName: venueNameController.text.trim(),
        venueAddress: venueAddressController.text.trim(),
        startAt: startDateTime,
        endAt: endDateTime,
        tickets: _buildTicketList(),
      );
      await localnotificationservice.show(
        title: 'New Event Added 🎉',
        body: eventNameController.text,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event created successfully!')),
        );
        navigationService.back();
      }
    } catch (e) {
      dialogService.showDialog(
        title: 'Failed',
        description: 'Could not create event. Try again.',
      );
    }

    setBusy(false);
  }

  @override
  void dispose() {
    eventNameController.dispose();
    descriptionController.dispose();
    venueNameController.dispose();
    venueAddressController.dispose();
    for (final t in tiers) {
      t.nameController.dispose();
      t.priceController.dispose();
      t.seatsController.dispose();
    }
    super.dispose();
  }
}
