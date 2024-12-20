import 'package:flutter/material.dart';

import 'services/deviceid_service.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Future<String?> futureDeviceId = DeviceId().getDeviceId();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              listData(
                'Privacy Policy',
                'YAYASAN NIZAMIA ANDALUSIA provide the NIZAMIA COMPASS app as a Free app. This SERVICE is provided by YAYASAN NIZAMIA ANDALUSIA at no cost and is intended for use as is.',
              ),
              bodyText(
                'This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.',
              ),
              bodyText(
                'If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.',
              ),
              bodyText(
                'The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at NIZAMIA CONNECT unless otherwise defined in this Privacy Policy.',
              ),
              listData(
                'Information Collection and Use',
                'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to YAYASAN NIZAMIA ANDALUSIA. The information that we request will be retained by us and used as described in this privacy policy.',
              ),
              listData(
                'Log Data',
                'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.',
              ),
              listData(
                'Cookies',
                "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.",
              ),
              bodyText(
                'This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.',
              ),
              listData(
                'Service Providers',
                'We may employ third-party companies and individuals due to the following reasons:',
              ),
              bodyText('To facilitate our Service;'),
              regularText('To provide the Service on our behalf;'),
              regularText('To perform Service-related services; or'),
              regularText('To assist us in analyzing how our Service is used.'),
              bodyText(
                'We want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.',
              ),
              listData(
                'Security',
                'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.',
              ),
              listData(
                'Links to Other Sites',
                'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
              ),
              listData(
                'Children’s Privacy',
                "We do not knowingly collect personally identifiable information from children. We encourage all children to never submit any personally identifiable information through the Application and/or Services. We encourage parents and legal guardians to monitor their children's Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application and/or Services without their permission. If you have reason to believe that a child has provided personally identifiable information to us through the Application and/or Services, please contact us. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf).",
              ),
              listData(
                'Changes to This Privacy Policy',
                'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.',
              ),
              bodyText('This policy is effective as of 2024-10-01'),
              listData(
                'Contact Us',
                'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at adm.hrdnizamiaandalusia@gmail.com.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listData(String text, String body) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        bodyText(body)
      ],
    );
  }

  Widget bodyText(String body) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          body,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black54),
        ),
      ],
    );
  }

  Widget regularText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black54),
    );
  }
}
