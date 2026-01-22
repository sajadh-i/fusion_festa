import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:fusion_festa/gen/fonts.gen.dart';
import 'package:fusion_festa/ui/screens/add_event/add_event_viewmodel.dart';

class AddEventView extends StatelessWidget {
  const AddEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEventViewModel>.reactive(
      viewModelBuilder: () => AddEventViewModel(),
      onViewModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        final size = MediaQuery.of(context).size;
        final height = size.height;
        final width = size.width;
        final h = height / 812;
        final w = width / 375;

        return Scaffold(
          backgroundColor: const Color(0xFF050304),
          appBar: AppBar(
            backgroundColor: const Color(0xFF050304),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              'Add New Event',
              style: TextStyle(
                fontFamily: FontFamily.inter,
                fontSize: 20 * w,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: vm.formKey,
              autovalidateMode: vm.autoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * w,
                  vertical: 16 * h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Image label
                    const _SectionLabel('Event Image'),
                    SizedBox(height: 8 * h),

                    // Animated image picker card
                    AnimatedScale(
                      scale: vm.imageScale,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      child: GestureDetector(
                        onTapDown: (_) => vm.onImageTapDown(),
                        onTapCancel: vm.onImageTapCancel,
                        onTapUp: (_) => vm.onImageTapUp(),
                        child: Container(
                          width: double.infinity,
                          height: 180 * h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F090B),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: vm.imageError == null
                                  ? const Color(0xFFFF8A3D)
                                  : Colors.redAccent,
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 40 * w,
                                      color: const Color(0xFFFF8A3D),
                                    ),
                                    SizedBox(height: 8 * h),
                                    Text(
                                      vm.selectedImageName ??
                                          'Tap to upload event image',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14 * w,
                                      ),
                                    ),
                                    SizedBox(height: 4 * h),
                                    Text(
                                      'JPG, PNG (min 1200×800px)',
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 11 * w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (vm.imageError != null)
                                Positioned(
                                  left: 12 * w,
                                  bottom: 8 * h,
                                  right: 12 * w,
                                  child: Text(
                                    vm.imageError!,
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 11 * w,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16 * h),

                    // Description
                    const _SectionLabel('Organized by'),
                    SizedBox(height: 8 * h),
                    _FusionTextField(
                      readonly: true,

                      hint: vm.organizerName.isNotEmpty
                          ? vm.organizerName
                          : "User",
                    ),
                    SizedBox(height: 8 * h),
                    _FusionTextField(
                      readonly: true,

                      hint: vm.organizerId.isNotEmpty
                          ? "UID : ${vm.organizerId} "
                          : "UID",
                    ),

                    SizedBox(height: 20 * h),

                    // Event Name
                    const _SectionLabel('Event Name'),
                    SizedBox(height: 8 * h),
                    _FusionTextField(
                      controller: vm.eventNameController,
                      hint: 'e.g., Mohiniyattam Recital',
                      validator: vm.validateEventName,
                    ),

                    SizedBox(height: 16 * h),

                    // Description
                    const _SectionLabel('Description'),
                    SizedBox(height: 8 * h),
                    _FusionTextField(
                      controller: vm.descriptionController,
                      hint:
                          'Share details about the event, its significance, and what attendees can expect.',
                      validator: vm.validateDescription,
                      maxLines: 4,
                    ),

                    SizedBox(height: 16 * h),

                    // Category
                    const _SectionLabel('Category'),
                    SizedBox(height: 8 * h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F090B),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: vm.categoryError == null
                              ? const Color(0xFF3A2C2A)
                              : Colors.redAccent,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: const Color(0xFF0F090B),
                          value: vm.selectedCategory,
                          hint: const Text(
                            'Select Category',
                            style: TextStyle(
                              color: Color(0xFF9B8E88),
                              fontSize: 13,
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFFFF8A3D),
                          ),
                          items: vm.categories
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(
                                    c,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            vm.selectedCategory = value;
                            vm.categoryError = null;
                            vm.notifyListeners();
                          },
                        ),
                      ),
                    ),
                    if (vm.categoryError != null) ...[
                      SizedBox(height: 4 * h),
                      Text(
                        vm.categoryError!,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 11,
                        ),
                      ),
                    ],

                    SizedBox(height: 16 * h),

                    // Date & Time
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionLabel('Start Date'),
                              SizedBox(height: 8 * h),
                              _FusionPickerField(
                                text: vm.startDateText ?? 'Select Date',
                                icon: Icons.calendar_today_outlined,
                                onTap: () => vm.pickStartDate(context),
                                errorText: vm.startDateError,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12 * w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionLabel('Start Time'),
                              SizedBox(height: 8 * h),
                              _FusionPickerField(
                                text: vm.startTimeText ?? 'Select Time',
                                icon: Icons.access_time_rounded,
                                onTap: () => vm.pickStartTime(context),
                                errorText: vm.startTimeError,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16 * h),

                    // Date & Time
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionLabel('End Date'),
                              SizedBox(height: 8 * h),
                              _FusionPickerField(
                                text: vm.endDateText ?? 'Select Date',
                                icon: Icons.calendar_today_outlined,
                                onTap: () => vm.pickEndDate(context),
                                errorText: vm.endDateError,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12 * w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionLabel('End Time'),
                              SizedBox(height: 8 * h),
                              _FusionPickerField(
                                text: vm.endTimeText ?? 'Select Time',
                                icon: Icons.access_time_rounded,
                                onTap: () => vm.pickEndTime(context),
                                errorText: vm.endTimeError,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16 * h),

                    // Venue details
                    const _SectionLabel('Venue Details'),
                    SizedBox(height: 8 * h),
                    _FusionTextField(
                      controller: vm.venueNameController,
                      hint: 'Venue Name',
                      validator: vm.validateVenueName,
                    ),
                    SizedBox(height: 12 * h),
                    _FusionTextField(
                      controller: vm.venueAddressController,
                      hint: 'Venue Address or Map Link',
                      validator: vm.validateVenueAddress,
                    ),

                    SizedBox(height: 16 * h),

                    const _SectionLabel('Ticket Pricing'),
                    SizedBox(height: 8 * h),

                    Column(
                      children: [
                        for (int i = 0; i < vm.tiers.length; i++) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: _FusionTextField(
                                  controller: vm.tiers[i].nameController,
                                  hint: i == 0
                                      ? 'Tier Name (e.g., General)'
                                      : i == 1
                                      ? 'Tier Name (e.g., VIP)'
                                      : 'Tier Name',
                                  validator: vm.validateTierName,
                                ),
                              ),
                              SizedBox(width: 12 * w),
                              Expanded(
                                flex: 2,
                                child: _FusionTextField(
                                  controller: vm.tiers[i].priceController,
                                  hint: 'Price (₹)',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  validator: vm.validateTierPrice,
                                ),
                              ),
                              SizedBox(width: 12 * w),
                              Expanded(
                                flex: 2,
                                child: _FusionTextField(
                                  controller: vm.tiers[i].seatsController,
                                  hint: 'Seats',
                                  keyboardType: TextInputType.number,
                                  validator: vm.validateTierSeats,
                                ),
                              ),
                              if (vm.tiers.length > 1)
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () => vm.removeTier(i),
                                ),
                            ],
                          ),
                          SizedBox(height: 12 * h),
                        ],
                      ],
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 420,
                        child: AnimatedOpacity(
                          opacity: vm.showAddTier ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFFF8A3D)),
                              foregroundColor: const Color(0xFFFF8A3D),
                              padding: EdgeInsets.symmetric(vertical: 12 * h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: const Color(0xFF0F090B),
                            ),
                            onPressed: vm.addTier,
                            icon: const Icon(Icons.add_circle_outline_rounded),
                            label: const Text('Add Another Ticket Tier'),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24 * h),

                    // Create event button
                    SizedBox(
                      width: double.infinity,
                      height: 52 * h,
                      child: ElevatedButton(
                        onPressed: vm.isBusy
                            ? null
                            : () => vm.onCreateEvent(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A3D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          elevation: 10,
                          shadowColor: const Color(0xFFFF8A3D).withOpacity(0.8),
                        ),
                        child: vm.isBusy
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Create Event',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 16 * h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFE6D7D0),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _FusionTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool enable;
  final bool readonly;

  const _FusionTextField({
    required this.hint,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
    this.enable = true,
    this.readonly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      controller: controller,
      enabled: enable,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: const Color(0xFFFF8A3D),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9B8E88), fontSize: 13),
        filled: true,
        fillColor: const Color(0xFF0F090B),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF3A2C2A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFFF8A3D), width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        ),
      ),
    );
  }
}

class _FusionPickerField extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final String? errorText;

  const _FusionPickerField({
    required this.text,
    required this.icon,
    required this.onTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F090B),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: hasError ? Colors.redAccent : const Color(0xFF3A2C2A),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: text.startsWith('Select')
                          ? const Color(0xFF9B8E88)
                          : Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
                Icon(icon, color: const Color(0xFFFF8A3D), size: 20),
              ],
            ),
          ),
        ),
        if (hasError) const SizedBox(height: 4),
        if (hasError)
          Text(
            errorText!,
            style: const TextStyle(color: Colors.redAccent, fontSize: 11),
          ),
      ],
    );
  }
}
