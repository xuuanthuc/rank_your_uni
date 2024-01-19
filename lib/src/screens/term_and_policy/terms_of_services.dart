import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import '../../../global/utilities/public.dart';
import '../guideline/guideline_screen.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      crossAxisAlignment: CrossAxisAlignment.start,
      maxContentWidth: Public.desktopSize,
      children: [
        Gap(),
        Gap(),
        TitleContent("ĐIỀU KHOẢN SỬ DỤNG"),
        Gap(),
        NormalContent(
            "Điều khoản này chứa điều khoản trọng tài và các điều khoản khước từ. Bằng cách sử dụng trang web này, người dùng được cho rằng là đồng ý với tất cả các điều khoản sử dụng của chúng mình."),
        Gap(),
        TitleContent("Các điều khoản sử dụng chính"),
        Gap(),
        NormalContent(
            "Nhằm mang lạ sự tiện lợi trong việc sử dụng web của chúng mình. Sau đây là bản tóm tắt nhanh về thoả thuận điều khoản sử dụng. Người dùng vui lòng đọc toàn bộ thoả thuận điều khoản sử dụng để biết thêm thông tin chi tiết. Nếu có bất kì sư thắc mắc nào. Xin liên hệ với chúng mình tại phần liên hệ."),
        Gap(),
        TitleContent(
            "Liên quan tới các thoả thuận, phạm vi và các điều khoản bổ sung:"),
        Gap(),
        NormalContent(
            "Thoả thuận điều khoản sử dụng này mô tả các quyền và trách nhiệm của người dùng liên quan đến trang web và các ràng buộc về mặt pháp lý giữa người dùng và Rank Your UNi"),
        NormalContent(
            "Thoả thận về các điều khoản bổ sung chi phối sản phẩm hoặc dịch vụ nhất định (các chương trình quảng cáo, marketing, trúng thưởng) cũng sẽ được áp dụng nếu người dùng tham gia vào bất kì hoạt động nào được cung cấp bởi Rank Your UNi."),
        NormalContent(
            "Luật pháp Việt Nam có các yêu cầu về độ tuổi và tính đủ điều kiện đối với trang web này. Chúng mình vận hành trang web này dưới luật pháp Việt Nam."),
        Gap(),
        TitleContent("Liên quan tới sửa đổi về điều khoản sử dụng"),
        Gap(),
        NormalContent(
            'Theo thời gian, các chính sách liên quan tới điều khoản sử dụng có thể có những sự thay đổi. Những thông tin quan trọng liên quan tới điều này sẽ được thông báo qua màn hình trang chủ của hoặc email mà người dùng đăng kí với chúng mình. Những điều khoản mới sẽ có hiệu lực tức thì tại thời điểm mà chúng mình cập nhật tại phần điều khoản sử dụng.'),
        Gap(),
        TitleContent('Liên quan tới quy tắc sử dụng'),
        Gap(),
        NormalContent(
            "Người dùng đồng ý sử dụng trang đúng đắn và không cho bất kì mục đích nào sai trái"),
        Gap(),
        TitleContent('Liên quan tới giao dịch, mua sắm online'),
        Gap(),
        NormalContent(
            'Các điều khoản được sử dụng trong việc giao dịch online có thể được bổ sung'),
        Gap(),
        TitleContent('Liên quan tới đánh giá, nội dung bài đăng'),
        Gap(),
        NormalContent(
            'Người dùng chịu trách nhiệm về bất kì nội dung nào mà họ đăng (hoặc dưới tên người dùng) trên hoặc thông qua trang web). Người dùng cũng chấp nhận rằng tất cả nội dung được cung cấp trong lúc sử dụng web sẽ được quản lý bởi chúng mình. Chúng mình có quyền đánh giá, chỉnh sửa và giám sát trong việc sàng lọc nội dung nếu nội dung của người dùng vi phạm điều khoản sử dụng của chúng mình. Hơn nữa, chúng mình cũng có quyền tước quyền sử dụng tài khoản của người dùng để đảm bảo chính sách này được thực thi.'),
        Gap(),
        TitleContent(
            'Liên quan tới việc miễn trừ trách nhiệm và giới hạn trách nhiệm pháp lý'),
        Gap(),
        NormalContent(
            'Người dùng hiểu rằng trang web được cung cấp không có bất kì sự bảo đảm hoặc tuyên bố bảo đảm. Chúng mình và Rank Your UNi từ chối mọi bảo đảm liên quan đến trang web và không chịu trách nghiệm về bất kì tổn thất hoặc thiệt hại nào liên quan đến trang web'),
        Gap(),
        TitleContent('Liên quan tới việc bồi thường'),
        Gap(),
        NormalContent(
            'Người dùng đồng ý bồi thường cho trang web Rank Your UNi và những chi phí phát sinh khác như các khiếu nại liên quan đến việc vi phạm thoả thuận điều khoản sử dụng. Điều này áp dụng lên tất cả các thông tin mà người dùng sử dụng để tương tác trên trang web'),
        Gap(),
        TitleContent('Liên quan tới luật và thẩm quyền xét sử'),
        Gap(),
        NormalContent(
            'Mọi khiếu nại liên quan đến việc cá nhân sử dụng trang web sẽ được giải quyết và xét xử dưới quyền hành và chịu sự trách nhiệm trước pháp luật tại Việt Nam'),
        Gap(),
        TitleContent('Những điều khoản sử dụng được áp dụng'),
        Gap(),
        TitleContent(
            '1. Thoả thuận, phạm vi và các điều khoản bổ sung'),
        Gap(),
        DotLine(
            'Trang web này được thiết kế hướng tới đối tượng cư trú, được quản lý và vận hành theo luật pháp của nước Việt Nam, tại lãnh thổ Việt Nam. Người dùng phải từ 16 tuổi trở lên (độ tuổi tối thiểu tham gia trường cao đẳng hoặc đại học tại Việt Nam). Để sử dụng một số tính năng của trang web, người dùng có thể phải tuân theo độ tuổi này (16) hoặc cao hơn'),
        Gap(),
        DotLine(
            'Các điều khoản và điều kiện này liên quan đến việc bạn sử dụng Trang web tạo thành một thỏa thuận ràng buộc về mặt pháp lý giữa một bên là người dùng và Rank Your UNi'),
        Gap(),
        DotLine(
            'Trong thoả thận này, các thuật ngữ liên quan đến website hoặc site hoặc trang web bao gồm tất cả các trang web hoặc  được liên kết với Rank Your UNi (tên miền, hoặc tên miền phụ khác) cũng như bất kì trang web tương đương, phản ánh hoặc thay thế. Bằng cách sử dụng trang web này, bạn hiểu thừa nhận và đồng ý rằng người dùng sẽ tuân thủ các điều khoản của thoả thuận này và mọi điều khoản bổ sung chi phối bởi các sản phẩm và dịch vụ nhất định được cung cấp'),
        Gap(),
        DotLine(
            'Các điều khoản bổ sung, bao gồm nhưng không giới hạn ở bất kì điều khoản nào có thể được cung cấp ở trang web liên quan đến việc gửi nội dung, phương tiện và tài liệu nội dung mà người dùng đăng trên trang web'),
        Gap(),
        TitleContent('2. Việc đăng kí sử dụng trang'),
        Gap(),
        DotLine(
            'Nếu chúng mình cung cấp dịch vụ đăng kí người dùng trên Rank Your UNi, để đăng kí làm thành viên của trang web, người dùng có thể có một số tuỳ chọn đăng kí (email, google mail), được mô tả trong chính sách quyền riêng tư'),
        Gap(),
        DotLine(
            'Mỗi thành viên sẽ sử dụng tên đăng nhập và mật khẩu được đặt cùng với ID người dùng (ID này là duy nhất) để truy cập và sử dụng một số tính năng hoặc chức năng nhất định mà chúng mình đã thiết kế cho người dùng'),
        Gap(),
        DotLine(
            'Chúng mình cũng có thể cung cấp cho người dùng mật khẩu mới hoặc mật khẩu bổ sung'),
        Gap(),
        DotLine(
            'Xin vui lòng đọc chính sách quyền riêng tư của chúng mình, nơi mà chúng mình giải thích các thông tin mà chúng mình thu thập, chia sẻ, quản lý, và lưu trữ'),
        Gap(),
        DotLine(
            'Thông tin tài khoản đăng nhập là riêng tư với người dùng. Người dùng không được phép chia sẻ hoặc tiết lộ với bất kì người nào khác. Trong trường hợp thông tin tài khoản đăng nhập được tiết lộ. Chúng mình không chịu trách nhiệm về bất kì tổn hại nào gây ra hoặc liên quan đến hành vi trộm cắp hoặc chiếm dụng tài khoản hoặc uỷ quyền. Người dùng đồng ý thông báo ngay cho chúng mình nếu họ tin rằng có thể có bất kì hành vi sử dụng trái phép nào gây tổn hại tới họ. Người dùng có thể liên hệ chúng mình qua tại phần liên hệ ở trang chủ để huỷ kích hoạt tài khoản trong trường hợp lo ngại về bảo mật'),
        Gap(),
        TitleContent('3. Sửa đổi và điều khoản sử dụng'),
        Gap(),
        DotLine(
            'Chúng tối có quyền sửa đổi các điều khoản của thoả thuận này bất kì thời điểm nào với bất kì lý do gì theo quyết định riêng của chúng mình bằng cách cập nhật thoả thuận điều khoản mà không cần thông báo trước cho người dùng. Chúng mình sẽ đăng hoặc hiển thị các thông báo quan trọng về những thay đổi quan trọng trên trang chủ Rank Your UNi hoặc gửi email tới người dùng. Những thay đổi sẽ có hiệu ngay tức thì khi được chúng mình cập nhật và người dùng sẽ bị ràng buộc bởi những thay đổi đó'),
        Gap(),
        TitleContent('4. Quyền sở hữu trí tuệ'),
        Gap(),
        DotLine(
            'Nội dung của trang web này (Rank Your UNi) bao gồm: phần mềm, thiết kế, văn bản, hình ảnh, ảnh chụp, hình minh hoạ, tài liệu âm thanh, video, đồ hoạ, cơ sở dữ liệu, thông tin độc quyền và tất cả các yếu tố khác được bảo vệ hợp phát, không giới hạn, việc lựa chọn giao diện và cách sắp xếp các dịch vụ, nhãn hiệu thuộc quyền sở hữu thương hiệu của Rank Your UNi và tất cả các sự kế thừa từ trang web'),
        Gap(),
        DotLine(
            'Trang web chỉ được sử dụng cho mục đích sử dụng cá nhân có giới hạn, phi thương mại, không độc quyền, không thể chuyển nhượng và không có mục đích nào khác. Người dùng không được che giấu bất ki bản quyền hoặc thông báo nào khác có trên trang web, bao gồm thông báo về bất kì tài liệu mà họ được phép tải xuống'),
        Gap(),
        DotLine(
            'Người dùng cũng sẽ không được phép chia sẻ cho bên thứ ba (liên quan tới bất kì lợi ích cá nhân nào về việc sao chép, sửa đổi hoặc tạo sản phấm nhái theo ý tưởng của chúng mình)'),
        Gap(),
        DotLine(
            'Bất kì việc sử dụng trái phép hoặc bị cấm đối với bất kì tài liệu nào đều có thể khiến người dùng chịu trách nhiệm dân sự, truy tố hình sự dựa theo luật hiện hành của pháp luật Việt Nam'),
        Gap(),
        DotLine(
            'Chúng mình yêu cầu người dùng tôn trọng bản quyền, nhãn hiệu và các quyền sở hữu trí tuệ khác của chúng mình. Ngược lại chúng mình cũng tôn trọng các tài sản trí tuệ của người dung'),
        Gap(),
        DotLine(
            'Trong trường hợp được thông báo, chúng mình sẽ hành động nhanh chóng để xoá nội dung trên trang web mà vi phạm quyền bản quyền của người khác, đồng thời vô hiệu hoá quyền truy cập vào trang web và các dịch vụ vi phạm quyền sở hữu trí tuệ của người khác'),
        Gap(),
        TitleContent('5. Các hoạt động quảng cáo'),
        Gap(),
        DotLine(
            'Bằng cách sử dụng trang của chúng mình, người dùng có thể tương tác, hoặc chuyển hướng đến hoặc tham gia các dịch vụ từ các bên thứ ba (gọi chung là “nhà quảng cáo”). Tất cả các thông tin liên lạc, tương tác và tham gia giữa người dùng và nhà quảng cáo nằm ở trong phạm vi mà phát luật cho phép và chúng mình KHÔNG CHỊU trách nhiệm, hoặc nghĩa vụ pháp lý với người dùng dưới bất kì hình thức nào liên quan tới các hoạt động giao dịch, giao ước, hợp đồng hoặc các điều kiện khác giữa họ và nhà quảng cáo'),
        Gap(),
        TitleContent('6. Quy tắc ứng xử'),
        Gap(),
        NormalContent(
            'Người dùng sử dụng trang web cần tuân theo các luật, quy tắc và quy định hiện hành mà chúng mình đưa ra. Người dùng sẽ chịu trách nhiệm hoàn toàn trước mọi hành động trên mạng thông qua tài khoản và mật khẩu của họ. Người dùng cũng có thể bị cấm sử dụng trang dưới những trường hợp sau đây:'),
        Gap(),
        DotLine(
            'Phỉ báng, bôi nhọ, không đúng đắn, thô tục, khiêu dâm, xúc phạm chủng tộc , văn hoá, quấy rối, đe doạ, hằn thù, phân biệt đối xử hoặc mạo danh bất kì ai'),
        Gap(),
        DotLine(
            'Nội dung thảo luận sai trái, cùng với thái độ tiêu cực, không rõ ràng, hoặc không liên quan tới sản phẩm, dịch vụ cũng như thông tin cá nhân mà trang web của chúng mình hướng tới'),
        Gap(),
        DotLine(
            'Ngăn cản cá nhân sử dụng dịch vụ, tính năng của trang web, quảng cáo, liên kết và các dịch vụ mà chúng mình cung cấp'),
        Gap(),
        DotLine(
            'Gửi email, tin nhắn với mục đích lừa đảo hoặc mạo danh chúng mình với mục đích trái phép'),
        Gap(),
        DotLine(
            'Sử dụng trang web, dịch vụ với mục đích thương mại hoặc kinh doan, không giới hạn, tiếp thị với bất kì mục đích tài chính, thương mại mà không có sự cho phép tới từ chúng mình'),
        Gap(),
        DotLine(
            'Tải lên các chương trình, tài liệu có chứa mã độc có khả năng gây hại tới Rank Your UNi'),
        Gap(),
        DotLine('Vi phạm luật an ninh mạng Việt Nam'),
        Gap(),
        DotLine('Vi phạm quyền sở hữu trí tuệ'),
        Gap(),
        DotLine(
            'Đăng nhập trái phép, sử dụng chức năng và dữ liệu cá nhân từ mọi thiết bị'),
        Gap(),
        DotLine(
            'Tấn công trang web bằng cách sửa đổi, làm gián đoạn hoạt động và việc vận hành trang web của chúng mình'),
        Gap(),
        DotLine('Lấy dữ liệu, hay crawl data từ trang web'),
        Gap(),
        DotLine(
            'Vi phạm với thoả thuận hoặc chính sách riêng tư hoặc bất kì chính sách nào mà chúng mình có thể bổ sung trong tương lại'),
        Gap(),
        TitleContent('7. Giao dịch mua bán online'),
        Gap(),
        DotLine(
            'Trong trường hợp chúng mình cung cấp một số dịch vụ thương mại điện tử nhất định, cho phép người dùng giao dịch, mua bán hàng hoá thông qua trang web của chúng mình, các điều khoản bổ sung sẽ được áp dụng cho việc sử dụng dịch vụ này'),
        Gap(),
        DotLine(
            'Người dùng có thể sử dụng các điều khoản có sẵn trên, hoặc thông quá các liên kết tới từ người bán hàng để biết thêm thông tin chi tiết'),
        Gap(),
        TitleContent('8. Nội dung và đánh giá'),
        Gap(),
        DotLine(
            'Nhận xét, đề xuất và và thông tin của người dùng là rất quan trọng đối với chúng mình. Một phần trang web của chúng mình có thể mang lại cho người dùng các cơ hội tham gia vào các diễn đàn, cộng đồng, blog, và các phương tiện liên lạc để trao đổi thông tin, ý tưởng, ý kiến (gọi chung là bài đăng). Với điều kiện chúng tuân thu các thoả thuận, chính sách mà chúng mình đưa ra'),
        Gap(),
        TitleContent('9. Các chương trình khuyến mại, cuộc thi'),
        Gap(),
        DotLine(
            'Chúng tối có thể tiến hành tổ chức các chương trình khuyến mãi thông qua trang web. Mỗi chương trình sẽ có thể có điều khoản bổ sung, quy tắc quản lý. Các nguyên tắc này sẽ được thông báo tới người dùng qua trang chủ và được coi là các điều khoản bổ sung và là một phần của thoả thuận của chúng mình'),
        Gap(),
        TitleContent('10. HyperLinks dẫn tới website của bên thứ ba'),
        Gap(),
        DotLine(
            'Chúng mình, những người quản lý, thuộc bộ phận quản lý của trang web Rank Your UNi, không chịu trách nhiệm với việc người dùng sử dụng URLs của bên thứ ba trong việc tham gia các hoạt động, dịch vụ mà bên thứ ba cung cấp. Chúng mình không có bất kì trách nhiệm nào với bên thứ ba và các hoạt động kinh doanh của họ (bao gồm cả chính sách bảo mật) ngay cả khi Rank Your UNi hợp tác, nhận sự tài trợ như một phần của thoả thuận giữa chúng mình (Rank Your UNi) và bên thứ ba'),
        Gap(),
        DotLine(
            'Vui lòng đọc chính sách bảo mật của chúng mình để hiểu rõ về việc chúng mình thu thập và chia sẻ dữ liệu cá nhân của người dùng'),
        Gap(),
        TitleContent('11. Ngừng kích hoạt/ Chấm dứt đăng kí tài khoản'),
        Gap(),
        DotLine(
            'Trang web của chúng mình cung cấp dịch vụ đăng kí để trở thành thành viên của Rank Your UNi và người dùng có thể đăng kí dưới tên đăng nhập và mật khẩu riêng của họ. Trong trường hợp bởi bất cứ lý do gì, người dùng có thể xoá tài khoản bằng các sử dụng chức năng “Xoá tài khoản” ở trong phần hồ sơ cá nhân. Trong trường hợp người dùng gặp trở ngại, hoặc không thể xoá, vui lòng thông báo bằng cách liên hệ'),
        Gap(),
        TitleContent(
            '12. Tuyên bố từ chối bảo đảm và giới hạn trách nhiệm pháp lý'),
        Gap(),
        DotLine(
            'Trang web (Rank Your UNi) và tất cả các tài sản, dịch vụ, bài đăng được thực hiện trên cơ sở “Nguyên trạng” và “Có sẵn”, mà không có bất kì đại diện hay đảm bảo nào dưới bất kì hình thức nào, hoặc bảo đảm rằng trang web sẽ thực hiện đúng các chức năng cho phép hoặc mô tả'),
        Gap(),
        DotLine(
            'Chúng mình không chịu trách nhiệm cho các mã độc (malicious sofware), độ trễ (delays), tính không chính xác (inaccuracies), lỗi web (errors), hoặc các thiếu sót khác liên quan tới việc sử dụng trang web của các người dùng, của cá nhân. Người dùng thừa nhận đồng ý rằng, trong phạm vi mà luật pháp cho phép, họ đang chịu trách nhiệm toàn bộ về các rủi ro về chất lượng, độ chính xác, hiệu suất, bảo mật và của bất kì tính năng nào'),
        Gap(),
        DotLine(
            'Người dùng hiểu và đồng ý rằng, trong phạm vi tối đa được pháp luật cho phép, Rank Your UNi và những người thuộc quyền hành quản lý hoặc tương ứng sẽ không chịu trách nhiệm về bất kì mất mát nào hay thiệt hại nào dưới bất kì hình thức trực tiếp, hay gián tiếp liên quan tới trang web hoặc thoả thuận này (bao gồm nhưng không giới hạn) ở bất kì quyền hạn hoặc quốc gia nào ngoài lãnh thổ Việt Nam'),
        Gap(),
        DotLine(
            'Trong phạm vi tối đa cho phép của pháp luật hiện hành, chúng mình từ chối các bảo đảm liên quan đến thông tin, phần mềm, sản phẩm và dịch vụ được cung cấp từ trang web Rank Your UNi. Chúng mình sẽ không chịu trách nhiệm về những thiệt hại trực tiếp, đặc biệt, gián tiếp, ngẫu nhiên (bao gồm cả mất mát về doanh thu hoặc lợi nhuận), sự trừng phạt hoặc cảnh cáo dưới bất kì hình thức nào tới từ người dùng hoặc bên bị ảnh hưởng'),
        Gap(),
        TitleContent('13. Bồi thường'),
        Gap(),
        DotLine(
            'Trong trường hợp bồi thường, bất kì người kế nhiệm và người chỉ định vận hành trang web, và các đối tác thứ ba khác của chúng mình sẽ không chịu trách nhiệm trước các khiếu nại, hành động, tổn thất, chi phí thiệt hại phát sinh liên quan tới các kiện cáo tới từ người dùng'),
        Gap(),
        DotLine(
            'Chúng mình (Rank Your UNi) có quyền đảm nhận, chịu trách nhiệm cho các chi phí của riêng mình, liên quan tới việc bảo vệ và kiểm soát độc quyền liên quan tới các khiếu nại hoặc các hành động đàm phán nhằm giải quyết các thoả hiệp từ người dùng'),
        Gap(),
        DotLine(
            'Người dùng đồng ý hợp tác đầy đủ với chúng mình để giải quyết hoặc đàm phán theo yêu cầu của chúng mình (Rank Your UNi)'),
        Gap(),
        TitleContent('14. Quảng cáo và các phần mềm độc hại'),
        Gap(),
        DotLine(
            'Chúng mình, những người quản lý Rank Your UNi, tự hào và luôn quan tâm tới cộng đồng học sinh, sinh viên Việt Nam, cũng như việc vận hành trang web này. Chúng mình luôn nâng cao cảnh giác cùng với các biện pháp đề phòng trục trặc kỹ thuật có thể ảnh hưởng trực tiếp tới cách hoạt động của trang web. Trong trường hợp các lỗ hổng được tìm thấy, chúng mình sẽ sửa chúng. Trong trường hợp lỗi được tìm thấy trên thiết bị của người dùng hoặc tới từ thiết bị người dùng, điều đó là nằm ngoài tầm kiểm soát của chúng mình và chúng mình rất tiếc rằng điều đó có thể sẽ không được khắc phục bởi chúng mình'),
        Gap(),
        DotLine(
            'Nếu người dùng gặp bất kì hành vi hoặc nội dung quảng cáo nào bất thường trên trang web của chúng mình, đó có thể là kết quả của phần mềm độc hại trên máy tính của họ. Điều này có thể tạo ra các lỗ hổng bảo mật và gây nguy hại cho người dùng bằng cách sử dụng thông tin cá nhân cho mục đích xấu. Do đó chúng mình khuyên người dùng nên thực hiện các hành động như cài đặt các phần mềm chống viruss để có thể giám sát hoặc ngăn chặn các phần mềm độc hại trong tương lai'),
        Gap(),
        TitleContent('15. Chính sách bảo mật'),
        Gap(),
        DotLine(
            'Chúng mình luôn tôn trọng quyền riêng tư cũng như sử dụng và bảo vệ thông tin của người dùng. Người cùng vui lòng xem Chính sách quyền riêng tư của chúng mình để biết thông tin quan trọng và các tiết lộ liên quan tới việc thu thập và sử dụng thông tin của họ liên quan đến việc sử dụng trang web của chúng mình'),
        Gap(),
        TitleContent('16. Các điều khoản khác'),
        Gap(),
        DotLine(
            'Thỏa thuận này, cùng với mọi Điều khoản bổ sung, Chính sách quyền riêng tư của chúng mình và mọi quy định, thủ tục và chính sách khác mà chúng mình đề cập đến và được kết hợp bằng cách tham chiếu, chứa đựng toàn bộ sự hiểu biết và thỏa thuận giữa bạn và trang web và thay thế bất kỳ và tất cả các điều khoản trước đó hoặc những hiểu biết không nhất quán liên quan đến trang web và việc bạn sử dụng trang web. Thỏa thuận này không thể được thay đổi hoặc chấm dứt bằng lời nói và không được sửa đổi trừ khi được mô tả trong thỏa thuận này. Nếu bất kỳ điều khoản nào của thỏa thuận này bị coi là bất hợp pháp, không hợp lệ hoặc không thể thi hành thì điều khoản này sẽ không ảnh hưởng đến bất kỳ điều khoản nào khác và thỏa thuận sẽ được coi là sửa đổi trong phạm vi cần thiết để làm cho nó hợp pháp, hợp lệ và có thể thi hành. Bất kỳ điều khoản nào phải có hiệu lực để cho phép chúng mình thực thi ý nghĩa của nó sẽ có hiệu lực sau khi thỏa thuận này chấm dứt; tuy nhiên, bạn không thể khởi kiện bất kỳ hành động nào liên quan đến thỏa thuận này hoặc việc sử dụng Trang web của bạn, bất kể hình thức hay cơ sở khiếu nại nào, sau hơn một (1) năm kể từ khi nguyên nhân khởi kiện phát sinh (hoặc nếu có nhiều nguyên nhân, kể từ ngày phát sinh nguyên nhân đầu tiên). Luật pháp và quy định của Việt Nam về việc tái sử dụng nội dung và bạn đồng ý không sử dụng, tái sử dụng bất kỳ tài liệu nào liên quan đến trang web vi phạm các luật và quy định đó'),
      ],
    );
  }
}
