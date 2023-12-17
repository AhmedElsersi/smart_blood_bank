import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_blood_bank/src/constants/colors.dart';
import 'package:smart_blood_bank/src/presentation/widgets/default_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: DefaultText(
          text: "About App",
          textColor: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 5.h),
          child: DefaultText(
            text:
                '''تطبيق البنك الذكي للدم هو نظام شامل مصمم لتيسير عمليات جمع وتوزيع الدم، مما يضمن الوصول الفعّال إلى الدم للمرضى الذين يحتاجون إليه. يهدف المشروع إلى التصدي لتحديات نقص الدم من خلال تنفيذ خوارزميات التنبؤ للتنبؤ بالطلب وتمكين توجيه الامدادات بشكل فعّال.

يوفر التطبيق واجهة سهلة الاستخدام للأفراد للبحث عن متبرعين بالدم بسهولة وتيسير جدولة المواعيد للتبرع بالدم. يتم تنفيذ إجراءات فحص واختبار صارمة لضمان سلامة وجودة الدم المتبرع به. يتم إنشاء قاعدة بيانات مركزية للمتبرعين بالدم يمكن الوصول إليها من قبل المستشفيات وبنوك الدم لتحسين توجيه الموارد.

يمكن للنظام أن يساعد المستشفيات في التغلب على نقص بنوك الدم من خلال تبادل الدم بينها، مما يقلل من الفاقد ويعزز الكفاءة. تُولد تقارير حول استهلاك وحدات الدم لتمكين اتخاذ قرارات مستنيرة وتوقع الطلب المستقبلي.

من خلال استغلال التكنولوجيا والنهج المستندة إلى البيانات، يهدف تطبيق البنك الذكي للدم إلى تعزيز التوفر والسلامة وسهولة الوصول إلى الدم للمرضى الذين يحتاجون إليه. يساهم المشروع في تحسين توزيع الدم، وتقليل النقص، وضمان توفير نقل الدم في الوقت المناسب.''',
            textAlign: TextAlign.right,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
