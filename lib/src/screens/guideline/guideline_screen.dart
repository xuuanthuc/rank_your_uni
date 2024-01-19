import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/style/app_colors.dart';
import '../widgets/base_scaffold.dart';

class GuidelinesScreen extends StatefulWidget {
  const GuidelinesScreen({Key? key}) : super(key: key);

  @override
  State<GuidelinesScreen> createState() => _GuidelinesScreenState();
}

class _GuidelinesScreenState extends State<GuidelinesScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        TitleContent('Hướng dẫn sử dụng trang'),
        SizedBox(height: 40),
        NormalContent(
            'Dưới đây là bản hướng dẫn sử dụng trang cho [Rank Your UNi](https://www.rankyouruni.com). Website được tạo, sử dụng và cung cấp bởi RYU Bản hướng dẫn sử dụng này là điều khoản bổ sung theo thoả thuận [điều khoản sử dụng](https://rankyouruni.com/terms) của chúng tôi.'),
        Gap(),
        NormalContent(
            'Rank Your UNi là trang web trực tuyến lớn nhất dành cho sinh viên nghiên cứu và đánh giá các trường đại học và giảng viên trên toàn vùng lãnh thổ Việt Nam. Mục đích của chúng mình là cung cấp một diễn đàn an toàn để chia sẻ kinh nghiệm học tập nhằm giúp các sinh viên đưa ra những sự lựa chọn đúng đắn về mặt giáo dục, cũng như góp phần cải thiện và nâng cao hệ thống giáo dục nước nhà.'),
        SizedBox(height: 20),
        TitleContent('WEBSITE'),
        NormalContent(
            'Trang web [RankYourUNi](https://www.rankyouruni.com) cho phép người dùng phản hồi về lối sống và cơ sở vật chất của các trường cao đẳng và đại học và tạo ra đánh giá về phương pháp giảng dạy của giảng viên và các khóa học tương ứng của họ.'),
        Gap(),
        NormalContent(
            'Xếp hạng trường học chỉ nên được đăng bởi các sinh viên đã theo học hoặc hiện đang theo học những khoá học cụ thể tại trường. Tương tự với việc xếp hạng giảng viên, người dùng chỉ nên đánh giá các giảng viên khi đã tham gia lớp học của giảng viên hoặc hiện đang theo khoá học cụ thể tại trường đang theo học.'),
        Gap(),
        NormalContent(
            'RankYourUNi KHÔNG phải là nơi để báo cáo các hành vi nguy hiểm, bất hợp pháp. Nếu bạn tin rằng bạn và các sinh viên khác đang gặp nguy hiểm, chúng mình khuyên bạn nên báo cáo những trường hợp đó trực tiếp cho trường hoặc các cơ quan có thẩm quyền'),
        SizedBox(height: 20),
        TitleContent('CÁCH CHÚNG MÌNH VẬN HÀNH TRANG WEB'),
        Gap(),
        NormalContent(
            'Tất cả các đánh giá trên Rank Your UNi được review bởi các quản trị viên. Thêm vào đó hướng dẫn sử dụng trang được đưa ra nhằm đảm bảo bất kì người dùng nào sử dụng trang web này đúng mục đích và sứ mệnh mà nhóm chúng mình đã đề ra. Bất kì đánh giá nào mang tính xúc phạm hoặc vi phạm hướng dẫn sử dụng trang sẽ bị xoá.'),
        Gap(),
        NormalContent(
            'Tất cả những đánh giá được giơ cờ sẽ được thông báo trực tiếp tới quản trị trang và được chúng mình review cũng như xoá khỏi đánh giá nếu là cần thiết. Chúng mình cam kết đánh giá của bạn sẽ không bị chỉnh sửa bởi chúng tôi.'),
        SizedBox(height: 40),
        TitleContent('HƯỚNG DẪN SỬ DỤNG TRANG WEB'),
        Gap(),
        TitleContent('Hướng dẫn sử dụng trang cho sinh viên:'),
        Gap(),
        DotLine(
            'Đánh giá đúng sự thật bởi chính bạn cũng sẽ mong muốn các đánh giá tới từ những sinh viên khác là đúng sự thật.'),
        Gap(),
        DotLine(
            'Khi đánh giá trường hay giảng viên, việc đánh giá điểm mạnh và điểm yếu là cần thiết bởi nó sẽ tăng điểm tin cậy cho đánh giá của bạn,'),
        Gap(),
        DotLine(
            'Đánh giá nên tập trung vào trải nghiệm tại học đường. Tuyệt đối không đánh giá ngoại hình, tuổi tác, giới tính của mọi người'),
        Gap(),
        DotLine(
            'Tránh đánh giá dựa trên cảm tính hay tới từ lời nói từ các cá nhân khác. Chúng mình muốn bạn chia sẽ trải nghiệm của chính mình chứ không phải dựa trên các cá nhân hay bất kì một tập thể nào khác.'),
        Gap(),
        DotLine(
            'RYU không phải là nơi để mở ra những cuộc thảo luận mang tính tiêu cự hay tạo xung đột. Bất kì đánh giá nào có liên quan tới việc công kích đánh giá khác sẽ bị xoá ngay lập tức. Nếu bạn không đồng ý với đánh giá khác, chúng mình rất khuyến khích bạn tạo đánh giá dựa trên trải nghiệm của riêng mình.'),
        Gap(),
        DotLine(
            'Chúng mình hiểu rằng các trường đại học đều có điểm mạnh và điểm yếu. Do đó chúng mình khuyến khích những đánh giá mang tính khách quan, giúp cho người đọc đánh giá hiểu rõ và đưa ra các quyết định đúng đắn.'),
        Gap(),
        DotLine(
            'Các đánh giá bắt nguồn từ cảm xúc tiêu cực có thể phản ánh không chính xác và có thể bị xoá vì vi phạm ngôn từ. Trước khi đồng ý đánh giá, hãy review lại để đảm bảo đánh giá của bạn là hữu ích'),
        Gap(),
        DotLine(
            'Khi đọc các bài đánh giá của bạn học, chúng mình khuyến khích bạn đưa ra quyết định dựa trên nhiều đánh giá khác bởi mục tiêu của Rank Your UNi là nguồn tài nguyên giúp các bạn sinh viên đưa ra các quyết định đúng đắn trên con đường học vấn của chính mình'),
        SizedBox(height: 30),
        TitleContent('Các nội dung cấm!!!'),
        Gap(),
        DotLine(
            'Những đánh giá thô tục, xúc phạm, liên quan tới tôn giáo, sắc tộc, giới tính, ngoại hình, tuổi tác và kỳ thị người khuyết tật sẽ được quản trị viên xoá ngay lập tức.'),
        Gap(),
        DotLine('Đánh giá liên quan tới đời sống cá nhân của các giảng viên'),
        Gap(),
        DotLine(
            'Đánh giá khẳng định rằng giảng viên của bạn đang phân biệt đối xử tới một hoặc nhóm người sinh viên.'),
        Gap(),
        DotLine('Đánh giá liên quan tới tình trạng nghề nghiệp của giảng viên'),
        Gap(),
        DotLine(
            'Đánh giá liên quan tới các hoạt động phạm pháp trong và ngoài trường học'),
        Gap(),
        DotLine(
            'Đánh giá cáo buộc rằng trường hoặc các giảng viên đang tự đánh giá cho chính họ.'),
        Gap(),
        DotLine('Mã link độc'),
        SizedBox(height: 30),
        TitleContent('BÁO CÁO ĐÁNH GIÁ'),
        Gap(),
        NormalContent(
            'Nếu bạn nhận thấy các đánh giá đang vi phạm hướng dẫn sử dụng Rank Your UNi, xin hãy nhấn “báo cáo” ở dưới mỗi đánh giá và mô tả mức độ vi phạm cũng như quan điểm của bạn về các đánh giá đó. Hạn chế báo cáo chỉ vì bạn không thích hoặc không cùng quan điểm với các đánh giá đó'),
        SizedBox(height: 30),
        TitleContent('MỘT VÀI TIÊU ĐIỂM VỀ PHÁP LÝ'),
        Gap(),
        NormalContent(
            "Có thể một vài tổ chức cá nhân nhận ra Rank Your UNi là một mối nguy hiểm tới họ. Điều này có thể dẫn tới các hành động liên quan đe doạ hoặc kiện cáo tới Rank Your UNi. Cho tới thời điểm hiện tại, chưa có trường hợp tiền đề nào thành công xảy ra hoặc các liên quan cáo buộc tới trang."),
        Gap(),
        NormalContent(
            "Nội dung của Rank Your UNi được tuân thủ và bảo vệ dưới bộ luật an ninh mạng, nghị định số 53/2022/NĐ-CP của chính phủ cộng hoà xã hội chủ nghĩa Việt Nam."),
        Gap(),
        NormalContent(
            "Bất kì ai có hành động tấn công hoặc mong muốn cáo buộc liên quan tới các vấn đề pháp lý sẽ chịu trách nhiệm trước pháp luật Việt Nam."),
        SizedBox(height: 30),
        TitleContent('QUYỀN CỦA Rank Your UNi'),
        Gap(),
        NormalContent(
            "Rank Your UNi có quyền xóa bất kỳ bình luận nào được coi là không phù hợp, bôi nhọ, phỉ báng, không đứng đắn, thô tục hoặc tục tĩu, khiêu dâm, khiêu dâm hoặc khêu gợi tình dục, xúc phạm chủng tộc, văn hóa hoặc sắc tộc, có hại, quấy rối, đe dọa, đe dọa, căm thù, phản cảm , phân biệt đối xử hoặc lạm dụng hoặc có thể mạo danh bất kỳ ai khác hoặc vi phạm hướng dẫn sử dụng trang."),
        Gap(),
        NormalContent(
            "Rank Your UNi có quyền xóa, cung cấp cho cơ quan chức năng hoặc thực hiện hành động thích hợp đối với các bình luận đe dọa bạo lực hoặc gây tổn hại cơ thể cho người dùng hoặc giảng viên khác, bao gồm nhưng không giới hạn ở việc thông báo cho cơ quan chức năng về địa chỉ IP của bạn, nếu thực sự cần thiết."),
        SizedBox(height: 50),
      ],
    );
  }
}

class Gap extends StatelessWidget {
  const Gap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}

class TitleContent extends StatelessWidget {
  final String title;

  const TitleContent(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.primaryTextTheme.labelLarge?.copyWith(fontSize: 14),
    );
  }
}

class NormalContent extends StatelessWidget {
  final String text;

  const NormalContent(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MarkdownBody(
      data: text,
      selectable: true,
      onTapLink: (t, u, c) async {
        if (u != null) {
          if (!await launchUrl(Uri.parse(u))) {
            throw Exception('Could not launch $u');
          }
        }
      },
      styleSheet: MarkdownStyleSheet(
        a: theme.primaryTextTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.info,
        ),
        p: theme.primaryTextTheme.bodyMedium,
      ),
    );
  }
}

class DotLine extends StatelessWidget {
  final String text;

  const DotLine(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 18, top: 8),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: NormalContent(text)),
      ],
    );
  }
}
