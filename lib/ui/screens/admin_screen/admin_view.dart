import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/admin_screen/admin_view_model.dart';
import 'package:fusion_festa/ui/screens/admin_screen/widget/admin_widget.dart';
import 'package:stacked/stacked.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminViewModel>.reactive(
      viewModelBuilder: () => AdminViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        final size = MediaQuery.of(context).size;
        final padding = size.width * 0.05;

        return Scaffold(
          backgroundColor: const Color(0xFF050814),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFF050814),
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            //   onPressed: viewModel.onBack,
            // ),
            centerTitle: true,
            title: const Text(
              'Event Approvals',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  viewModel.adminLogout();
                },
                icon: const Icon(Icons.logout, color: Colors.white),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.015),

                  // top summary cards – counts come from ViewModel
                  SizedBox(
                    height: size.height * 0.13,
                    child: Row(
                      children: [
                        Expanded(
                          child: StatusCard(
                            icon: Icons.folder_open_rounded,
                            iconColor: const Color(0xFFFFC46B),
                            label: 'Pending',
                            count: viewModel.pendingCount,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Expanded(
                          child: StatusCard(
                            icon: Icons.check_circle,
                            iconColor: const Color(0xFF46C980),
                            label: 'Approved',
                            count: viewModel.approvedCount,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Expanded(
                          child: StatusCard(
                            icon: Icons.close_rounded,
                            iconColor: const Color(0xFFE85C5C),
                            label: 'Rejected',
                            count: viewModel.rejectedCount,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'New Requests',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: Color(0xFF4D9FFF),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.02),

                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: viewModel.requests.length,
                      itemBuilder: (context, index) {
                        final req = viewModel.requests[index];
                        return AnimatedRequestCard(
                          delay: index * 80,
                          request: req,
                          onAccept: () => viewModel.acceptRequest(req.id),
                          onReject: () => viewModel.rejectRequest(req.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
