import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_hostel/components/agent.dart';
import 'package:my_hostel/components/hostel_info.dart';
import 'package:my_hostel/misc/constants.dart';
import 'package:my_hostel/misc/functions.dart';
import 'package:my_hostel/misc/providers.dart';
import 'package:my_hostel/misc/widgets.dart';
import 'package:my_hostel/pages/profile/owner/profile.dart';

class AgentsPage extends ConsumerStatefulWidget {
  const AgentsPage({super.key});

  @override
  ConsumerState<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends ConsumerState<AgentsPage> {
  List<Agent> agents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Co-workers",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Text(
                "The list of co-workers working with you "
                "to help managing and promoting the hostel listings.",
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: weirdBlack75,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    if (index == agents.length) {
                      return SizedBox(height: 100.h);
                    }
                    return _AgentCard(
                      agent: agents[index],
                      status: AgentStatus.accepted,
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  itemCount: agents.length + 1,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70.h,
        child: GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AgentInvite(),
          ),
          child: Container(
            width: 414.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appBlue,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/Invite Agent.svg"),
                SizedBox(width: 5.w),
                Text(
                  "Invite Agent",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AgentStatus { accepted, pending, rejected }

class _AgentCard extends StatelessWidget {
  final Agent agent;
  final AgentStatus status;

  const _AgentCard({
    super.key,
    required this.agent,
    required this.status,
  });

  String get _statusText {
    switch (status) {
      case AgentStatus.accepted:
        return "Accepted";
      case AgentStatus.pending:
        return "Pending";
      case AgentStatus.rejected:
        return "Rejected";
    }
  }

  Color get _statusColor {
    switch (status) {
      case AgentStatus.accepted:
        return Colors.green;
      case AgentStatus.pending:
        return Colors.yellow;
      case AgentStatus.rejected:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pushNamed(
        Pages.viewAgent,
        extra: AgentData(
          agent: agent,
          status: status,
        ),
      ),
      child: Container(
        width: 414.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE0E5EC),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50.r,
              height: 50.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE0E5EC),
                    blurRadius: 1.0,
                    spreadRadius: 2.0,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Container(
                width: 45.r,
                height: 45.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(agent.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 260.w,
              child: Column(
                children: [
                  Text(
                    agent.mergedNames,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: weirdBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    agent.email,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Invite Sent: ${formatDateWithTime(agent.dateJoined)}",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: weirdBlack75,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _statusText,
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: _statusColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AgentData {
  final Agent agent;
  final AgentStatus status;

  const AgentData({
    required this.agent,
    required this.status,
  });
}

class ViewAgentPage extends StatelessWidget {
  final AgentData data;

  const ViewAgentPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 26.r,
          splashRadius: 0.01,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Co-worker",
          style: context.textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, color: weirdBlack),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Container(
                  width: 125.r,
                  height: 125.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFE0E5EC),
                        blurRadius: 1.0,
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 118.r,
                    height: 118.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(data.agent.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  data.agent.mergedNames,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: weirdBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  data.agent.email,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: weirdBlack75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                if (data.status == AgentStatus.accepted)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async => launchContactUrl(data.agent.contact),
                        child: Text(
                          data.agent.contact,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: weirdBlack75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/Roomate Info Location.svg",
                            width: 15.r,
                            height: 15.r,
                            color: weirdBlack50,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            data.agent.address,
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: weirdBlack50,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 414.w,
                          minHeight: 1.h,
                          maxWidth: 414.w,
                          maxHeight: 1.h,
                        ),
                        child: const ColoredBox(color: Colors.black12),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Personal Info",
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: weirdBlack),
                      ),
                      SizedBox(height: 15.h),
                      ProfileInfoCard(
                        image: "assets/images/Profile Blue Location.svg",
                        header: data.agent.address,
                        text: "Personal Address",
                      ),
                      SizedBox(height: 15.h),
                      ProfileInfoCard(
                        image: "assets/images/Profile Religion.svg",
                        header: data.agent.religion,
                        text: "Religion",
                      ),
                      if (data.agent.religion == "Christianity")
                        SizedBox(height: 15.h),
                      if (data.agent.religion == "Christianity")
                        ProfileInfoCard(
                          image: "assets/images/Profile Church.svg",
                          header: data.agent.denomination,
                          text: "Denomination",
                        ),
                      SizedBox(height: 15.h),
                      ProfileInfoCard(
                        image: "assets/images/Profile Age.svg",
                        header: formatDateRaw(data.agent.dob),
                        text: "Date of Birth",
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                if (data.status == AgentStatus.pending)
                  Column(
                    children: [
                      SizedBox(height: 10.h),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 414.w,
                          minHeight: 1.h,
                          maxWidth: 414.w,
                          maxHeight: 1.h,
                        ),
                        child: const ColoredBox(color: Colors.black12),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Pending...",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: weirdBlack75,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "We are waiting for your invitee to accept your invite.",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: weirdBlack50,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
