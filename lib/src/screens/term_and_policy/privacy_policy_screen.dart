import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';

import '../../../global/utilities/public.dart';
import '../guideline/guideline_screen.dart';
import '../widgets/responsive_builder.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveBuilder.setHorizontalPadding(context)),
            constraints: const BoxConstraints(
              maxWidth: Public.desktopSize,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(),
                Gap(),
                Gap(),
                NormalContent("Chính Sách Bảo Mật"),
                Gap(),
                NormalContent(
                    "Đây là chính sách bảo mật nơi mà chúng tôi mô tả các biện pháp bảo mật thông tin đối với trang web và các dịch vụ tương tác khác. Trang web [http://www.rankyouruni.com] được sở hữu và vận hành bởi các quản trị viên của chúng tôi"),
                Gap(),
                TitleContent(
                    "Chính sách bảo mật nay bao gồm những mục lục sau:"),
                Gap(),
                DotLine("Các trường hợp mà chính sách này áp dụng"),
                Gap(),
                DotLine("Luật an ninh mạng 2018 của Việt Nam"),
                Gap(),
                DotLine("Những thông tin được thu thập"),
                Gap(),
                DotLine("Cách thông tin được thu thập"),
                Gap(),
                DotLine("Quyền của người dùng"),
                Gap(),
                DotLine("Chia sẻ và tiết lộ thông tin"),
                Gap(),
                DotLine("Chỉnh sửa xoá các thông tin"),
                Gap(),
                DotLine("Bảo vệ thông tin"),
                Gap(),
                DotLine("Những thay đổi về chính sách bảo mật"),
                Gap(),
                DotLine("Các điều khoản phù hợp khác"),
                Gap(),
                Gap(),
                TitleContent("1. Các trường hợp mà chính sách này áp dụng"),
                Gap(),
                DotLine(
                    "Bất kể người dùng đang truy cập trang web của chúng tôi thông qua bất kì thiết bị máy tính, di động hay thiết bị công nghệ nào khác đã được biết tới tính từ thời điểm hiện tại cho tới tương lai và được cho là “thiết bị“"),
                Gap(),
                DotLine(
                    "Cho dù người dùng đang truy cập trang web với tư cách là người dùng đã đăng kí hoặc chưa đăng kí"),
                Gap(),
                DotLine(
                    "Đối với tất cả những từ ngữ, thuật ngữ được định nghĩa bên dưới, thu thập bởi chúng tôi"),
                Gap(),
                DotLine(
                    "Đối với các thông tin, nhóm thông tin được chúng tôi thu thập từ các nguồn khác. Ví dụ như thông tin về địa chỉ và IP đăng nhập được nhận bởi google với mục đích quảng cáo"),
                Gap(),
                DotLine(
                    "Tất cả sẽ được tính có hiệu lực đầy đủ kể từ lúc người dùng sử dụng hoặc tham gia trang web, sử dụng bất kì tính năng, chức năng và hoạt động quảng cáo cụ thể nào được cung cấp qua trang web kể cả khi các hoạt động đó đã được xoá, hết hạn hoặc đóng bất kể lí do gì"),
                Gap(),
                NormalContent(
                    "Chính sách này không áp dụng tới bất kì thông tin nào được thu thập bởi các bên thứ ba khác hoặc bởi bất kì website hay ứng dụng nào"),
                Gap(),
                TitleContent("2. Luật an ninh mạng Việt Nam 2018"),
                Gap(),
                NormalContent(
                    "Website của chúng tôi hướng tới được sử dụng bởi người dùng tại Việt Nam, và được quản lý và tuân theo pháp luật của Việt Nam. Nếu người dùng sử dụng website của chúng tôi từ lãnh thổ khác ngoài Việt Nam, người dùng có thể phải chịu sự rủi ro và chúng tôi không chịu trách nhiệm dưới luật pháp ngoài Việt Nam"),
                Gap(),
                NormalContent(
                    "Xin hãy hiểu rằng sử dụng trang web đồng nghĩa với việc"),
                Gap(),
                DotLine(
                    "Các thông tin cá nhân sẽ được thu thập và có thể chịu sự quản lý bởi luật an ninh mạng của Việt Nam"),
                Gap(),
                DotLine(
                    "Người dùng đồng ý với việc dữ liêu (data) sẽ được lưu trữ, trao đổi thông tin trên mạng ở Việt Nam"),
                Gap(),
                DotLine(
                    "Hiểu rằng luật an ninh mạng Việt Nam có thể có những tiêu chuẩn chưa đủ để bảo vệ thông tin cá nhân của bạn tại địa điểm ngoài vùng lãnh thổ Việt Nam"),
                Gap(),
                DotLine(
                    "Hiểu rằng dữ liệu cá nhân về việc sử dụng web của bạn sẽ được thu thập, sử dụng, và lưu trữ và được xử lý, tuân theo chính sách quyền riêng tư này"),
                Gap(),
                NormalContent(
                    "Do đó, dựa trên phạm vi của phát luật cho phép, người dùng có thể từ bỏ mọi khiếu nại liên quan tới việc xử lý thông tin cá nhân, hoặc các thông tin khác đã được định nghĩa theo chính sách quyền riêng tư của chúng tôi hoặc các điều luật liên quan tới chính sách quyền riêng tư ở bất kỳ quốc gia nào khác"),
                Gap(),
                TitleContent("3. Những thông tin được thu thập"),
                Gap(),
                TitleContent("Các thông tin được cung cấp bởi người dùng"),
                Gap(),
                DotLine("Thông tin đăng nhập"),
                Gap(),
                NormalContent(
                    "Để trở thành thành viên của RYU, người dùng được yêu cầu đăng kí tên đăng nhập và mật khẩu (mỗi tài khoản được đăng kí sẽ được lưu trữ dưới “User ID”). Người dùng sẽ được yêu cầu cung cấp email và ngày tháng năm sinh. Các thông tin khác có thể được yêu cầu trong quá trình đăng kí tài khoản"),
                Gap(),
                NormalContent(
                    "Sau khi được cung cấp tài khoản, người dùng có thể sử dụng tài khoản được cung cấp để sử dụng website hoặc bất kì tính năng hoặc các dịch vụ được chúng tôi cấp phép tới thời điểm hiện tại hoặc trong tương lai"),
                Gap(),
                NormalContent(
                    "Trang website, ứng dụng và các dịch vụ tương tác khác có thể có những yêu cầu riêng biệt với một số người dùng nhất định. Ví dụ như yêu cầu tối thiểu về độ tuổi đối với người dùng"),
                Gap(),
                NormalContent(
                    " Hơn nữa, vì quyền riêng tư của người dùng là cần thiết, chúng tôi khuyên rằng nếu thiết bị của bạn có thể truy cập từ người khác, xin hãy đăng xuất sau trang web hoặc các dịch vụ khác được cung cấp bởi chúng tôi"),
                DotLine(
                    "Việc liên quan tới các tính năng và chức năng nhất định"),
                Gap(),
                NormalContent(
                    "Chúng tôi có thể cung cấp cho người dùng một số quyền truy cập vào các tính năng hoặc chức năng nhất định. Ví dụ như việc tham gia bình luật, mua sắm hoặc hồ sơ thành viên.  Để có thể sử dụng các tính năng này, người dùng cần cung cấp một số thông tin nhất định để chúng tôi có thể cá nhân hoá và cải thiện trải nghiệm của người dùng"),
                Gap(),
                DotLine(
                    "Việc liên quan tới các chương trình tiếp thị, khuyến mãi"),
                Gap(),
                NormalContent(
                    "Người dùng có thể phải cung cấp các thông tin như họ tên, ngày tháng năm sinh, địa chỉ, email, số điện thoại để tham dự các chương trình tiếp thị từ các đối tác của chúng tôi trong lúc người dùng sử dụng trang web"),
                Gap(),
                NormalContent(
                    "Lưu ý: các thông tin cá nhân khác có thể phải bổ sung, tuỳ theo chương trình tiếp thị. Chi tiết sẽ được bổ sung và nêu rõ ở phần đăng nhập chương trình, nếu có"),
                Gap(),
                TitleContent(
                    "Các thông tin được thu thập qua việc sử dụng Cookies hoặc các công nghệ theo dõi người dùng khác"),
                NormalContent(
                    'Trang web của chúng tôi, hoặc gắn từ bên thứ ba có thể sử dụng Cookies, Web Beacons hoặc những phần mềm tương tự để tự động thu thập thông tin, dữ liệu người dùng'),
                Gap(),
                TitleContent('Định nghĩa:'),
                Gap(),
                NormalContent(
                    'Cookies: là file được dùng để lưu trữ các thông tin, hoạt động của người dùng'),
                Gap(),
                NormalContent(
                    'Web Beacons: là các hình ảnh ẩn theo dõi web bug'),
                Gap(),
                NormalContent(
                    'Các phần mềm này thu thập những thông tin liên quan tới luồng tương tác dữ liệu (Clickstream data) và các dữ liệu khác như (số lần truy cập, trình duyệt, hệ điều hành, thời gian truy cập và việc tương tác giữa các chức năng và dịch vụ khác'),
                Gap(),
                DotLine(
                    "Cách website sử dụng các công nghệ thu thập dữ liệu data của người dùng"),
                Gap(),
                NormalContent(
                    "Bằng cách truy cập vào trang web của chúng tôi, đăng nhập hoặc không đăng nhập tài khoản, người dùng hiểu rằng bạn đang cho phép chúng tôi theo dõi các hoạt động sử dụng trang và sự tương tác của bạn đối với các dịch vụ chúng tôi hoặc bên thứ 3 cung cấp"),
                Gap(),
                NormalContent(
                    "Chúng tôi sử dụng các phần mềm theo dõi người dùng giúp chúng tôi thu thập và theo dõi dữ liệu (được mô tả ở mục 4.2 dưới). Ví dụ, chúng tôi có thể sử dụng phần mềm theo dõi người dùng để ngăn người dùng cùng nhìn thấy một hoặc nhiều quảng cáo quá nhiều lần. Để điều chỉnh trải nghiệm của người dùng trên web, chúng tôi sẽ cá nhân hoá, điều chỉnh tiếp thị quảng cáo, email và nội dung khác, hoặc được sử dụng các lựa chọn ngưng nhận quảng cáo qua cơ chế từ mail, để chúng tôi biết rằng bạn không muốn nhận các quảng cáo được cá nhân hoá từ chúng tôi"),
                Gap(),
                DotLine(
                    "Cách các bên thứ 3 sử dụng phần mềm để thu thập dữ liệu"),
                Gap(),
                DotLine(
                    " Trang web của chúng tôi có thể sử dụng các phần mềm từ bên thứ ba để trao đổi dữ liệu, quản lý dữ liệu, đo lường lượng truy cập và cung cấp hoặc trao đổi các dịch vụ quảng cáo, phân tích tiếp thị, tạo điều kiện cho việc cá nhân hoá các dịch vụ marketings. Giúp bạn tìm tới những sản phẩm và dịch vụ mà bạn quan tâm"),
                Gap(),
                DotLine(
                    "Bên thứ ba và các nhà quảng cáo khác có thể tự thiết lập các phần mềm, công nghệ được phê duyệt đảm bảo tính bảo mật để truy cập thông tin và các hoạt động trực tuyến của bạn theo thời gian thực khi bạn sử dụng trang web của chúng tôi"),
                Gap(),
                DotLine(
                    "Chúng tôi có thể can thiệp để hỗ trợ nhà cung cấp dịch vụ từ bên thứ ba để trang web có thể thiết lập công nghệ theo dõi. Ví dụ trong phạm vi cần thiết để cung cấp các dịch vụ phục vụ quảng cáo cơ bản như kiểm soát tần suất bạn xem quảng cáo hoặc đảm bảo bạn không xem một quảng cáo quá nhiều lần, chúng tôi có thể tranh thủ sự trợ giúp của bên thứ ba để tạo, tuỳ chỉnh hoặc sửa đổi các công nghệ mà trang web thiết lập"),
                Gap(),
                TitleContent("4. Cách mà chúng tôi sử dụng thông tin của bạn"),
                Gap(),
                TitleContent("Các dữ liệu mà bạn cung cấp"),
                Gap(),
                NormalContent(
                    "Chúng tôi sử dụng dữ liệu cá nhân mà người dùng cung cấp dưới nhiều hình thức. Ví dụ như:"),
                Gap(),
                DotLine(
                    "Gửi thử quảng cáo, chiến dịch quảng cáo, tin nhắn từ chúng tôi hoặc bên thứ ba về những sản phẩm hoặc dịch vụ mà người dùng có thể quan tâm hoặc chú ý"),
                Gap(),
                DotLine(
                    "Xác thực email đăng kí với chúng tôi để chúng tôi biết rằng email của người dùng là khả dụng"),
                Gap(),
                DotLine(
                    "Liên hệ với người dùng và việc quản lý tài khoản của người dùng trong việc sử dụng các tính năng, chức năng mà người dùng đăng ký sử dụng, các khuyến mãi mà người dùng tham gia, giao dịch hoặc bất kì dịch vụ mà chúng tôi cung cấp tới người dùng"),
                Gap(),
                DotLine(
                    "Cho phép người dùng sử dụng trang web và các tính năng mà chúng tôi mang lại"),
                Gap(),
                DotLine(
                    "Liên hệ và trả lời bất kì những câu hỏi hoặc yêu cầu nào từ người dùng"),
                Gap(),
                DotLine(
                    "Liên hệ về các thông tin mới (chức năng, điều khoản) mà trang web của chúng tôi có thể cập nhật"),
                Gap(),
                DotLine(
                    "Điều chỉnh trải nghiệm của người dùng về mặt nội dung hoặc những gì họ thấy khi truy cập trang"),
                Gap(),
                DotLine(
                    "Điều chỉnh trải nghiệm liên quan tới ứng dụng hoặc dịch vụ được vận hành bởi chúng tôi hoặc bên thứ ba"),
                Gap(),
                DotLine(
                    "Lưu lại UserID, cookies để giúp người dùng truy cập web mà không cần phải đăng nhập lại"),
                Gap(),
                DotLine(
                    "Ngoài ra với các mục đích khác được tiết lộ tại thời điểm người dùng cung cấp thông tin cá nhân (ví dụ: quy tắc với các chương trình quảng cáo tại thời điểm người dùng tham gia)"),
                Gap(),
                TitleContent(
                    "Thông tin nhận dạng được thu thập bởi các công nghệ theo dõi"),
                Gap(),
                DotLine(
                    "Đếm số lần người dùng truy cập hoặc nhấn vào quảng cáo hoặc website đến từ bên thứ ba"),
                Gap(),
                DotLine(
                    "Sử dụng để đánh giá, report liên quan tới dữ liệu thống kê về việc sử dụng của người dùng"),
                Gap(),
                DotLine(
                    "Phân tích, sử dụng phương pháp A/B testing để xác định hoặc dự đoán những tính năng, trang web, sản phẩm và dịch vụ mà người dùng thích nhất. Nhằm mong muốn nâng cao và cải thiện các dịch vụ, ứng dụng. Ví dụ như việc người dùng nhấn vào quảng cáo được gửi qua email của chúng tôi"),
                Gap(),
                DotLine("Địa chỉ IP"),
                Gap(),
                DotLine("Quốc gia, thành phố"),
                Gap(),
                DotLine(
                    "Lịch sử duyệt web ở trên trang web của chúng tôi, bao gồm cả việc cách bạn được giới thiệu tới trang web của chúng tôi"),
                Gap(),
                DotLine("Thông tin về thiết bị được sử dụng để đăng nhập"),
                Gap(),
                DotLine(
                    "Nếu bạn sử dụng chi tiết đăng nhập Google của mình, bạn cho phép Google chia sẻ dữ liệu cá nhân mà bạn đã công khai trong hồ sơ trên Google của mình. Thông tin này chỉ bao gồm họ và tên, địa chỉ email"),
                Gap(),
                DotLine(
                    "Và cho nhiều mục đích khác tại thời điểm mà dữ liệu được thu thập"),
                Gap(),
                TitleContent(
                    "Thông tin được thu thập bởi các dịch vụ được cung cấp bởi bên thứ ba"),
                Gap(),
                DotLine(
                    "Việc sử dụng các công nghệ theo dõi của nhà cung cấp dịch vụ quảng cáo từ bên thứ ba nằm trong tầm kiểm soát của họ chứ không phải của chúng tôi. Ngay cả khi chúng tôi có mối quan hệ với nhà cung cấp các dịch vụ quảng cáo. Chúng tôi không kiểm soát trang web, ứng dụng hoặc dịch vụ tương tác khác của bên thứ ba, cũng như các chính sách và hoạt động liên quan tới việc sử dụng dữ liệu của người dùng"),
                Gap(),
                DotLine(
                    "Người dùng nên biết rằng các thông tin, dữ liệu của họ được áp dụng bởi các quy tắc khác nhau mà có thể được đề xuất bởi bên thứ ba"),
                Gap(),
                DotLine(
                    "Việc sử dụng hoặc tiết lộ thông tin của bạn bởi bên thứ ba liên quan tới quảng cáo, khuyến mãi và các dịch vụ khác trong ứng dụng hoặc tương tác trên internet sẽ không nằm trong chính sách của chúng tôi"),
                Gap(),
                DotLine(
                    "Tuy nhiên, người dùng có thể tham khảo phần “lựa chọn của bạn” để biết thêm thông tin về cách từ chối thu thập và sử dụng thông tin từ bên cung cấp dịch vụ thứ ba"),
                Gap(),
                TitleContent("5. Lựa chọn của bạn"),
                Gap(),
                DotLine(
                    "Từ chối nhận các bản tin, email hoặc các khuyến mại quảng cáo bằng cách sử dụng cơ chế từ chối có trong mỗi email hoặc các cơ chế khác mà chúng tôi có thể cung cấp. Lưu ý, khi người dùng chọn không tham gia nhận email, đồng nghĩa người dùng sẽ không tham gia vào các dịch vụ tiếp thị và quảng cáo sản phẩm mà chúng tôi cung cấp trong tương lai"),
                Gap(),
                NormalContent(
                    "Ngay cả khi tài khoản được người dùng huỷ kích hoạt, người dùng vẫn sẽ nhận được email từ chúng tôi trừ khi người dùng thực hiện các tuỳ chọn từ chối mà chúng tôi đề cập ở trên. Ngay cả khi bạn thực hiện các quyền từ chối được mô tả ở trên, chúng tôi vẫn có thể tiếp tục liên hệ với các người dùng vì các mục đích khác được mô tả trong mục 4"),
                Gap(),
                DotLine(
                    "Từ chối các công nghệ theo dõi bằng cách sử dụng cơ chế từ chối có trong mỗi email hoặc các cơ chế khác mà chúng tôi có thể cung cấp. Lưu ý, khi bạn chọn không tham gia nhận email, đồng nghĩa người dùng sẽ không tham gia vào các dịch vụ tiếp thị và quảng cáo sản phẩm mà chúng tôi cung cấp trong tương lai"),
                Gap(),
                NormalContent(
                    "Ngay cả khi tài khoản được người dùng huỷ kích hoạt, người dùng vẫn sẽ nhận được email từ chúng tôi trừ khi người dùng thực hiện các tuỳ chọn từ chối mà chúng tôi đề cập ở trên. Ngay cả khi bạn thực hiện các quyền từ chối được mô tả ở trên, chúng tôi vẫn có thể tiếp tục liên hệ với các bạn vì các mục đích khác được mô tả trong mục 4"),
                Gap(),
                NormalContent(
                    'Các sự lựa chọn ở trên đã bao gồm cookie trình duyệt do trang web của chúng tôi. Các cookie khác không được kiểm soát (hay còn được gọi là cookie của bên thứ 3) sẽ không do chúng tôi kiểm soát và sẽ không chịu trách nhiệm về việc vận hành của các cookie của các trình duyệt khác'),
                Gap(),
                DotLine(
                    'Các công cụ dựa vào cookie trình duyệt internet để ghi nhớ các sự lựa chọn của người dùng. Nếu người dùng lựa chọn xoá hoặc chỉnh sửa cookie ở trong trình duyệt web, người dùng có thể phải chỉnh sửa, xoá hoặt thiết lập lại các sự lựa chọn cookie cá nhân khi có những sự thay đổi mới ở trong tương lai'),
                Gap(),
                DotLine(
                    'Lưu ý, việc xoá cookie cho một trình duyệt không đồng nghĩa với việc cookie cũng sẽ bị xoá trên các trình duyệt khác'),
                Gap(),
                DotLine(
                    'Một vài trình duyệt có thể mặc định vô hiệu hoá Cookie (VD: Safari). Điều này có thể ảnh hưởng đến dịch vụ tương tác hoặc các dịch vụ khác mà chúng tôi hoặc bên thứ ba mang lại (VD: quảng cáo)'),
                Gap(),
                DotLine(
                    'Người dùng vẫn có thể nhìn thấy quảng cáo trên trang Web của chúng tôi. Việc vô hiệu hoá cookie không đồng nghĩa là người dùng sẽ không còn nhìn thấy quảng cáo của chúng tôi. Việc xoá cookie chỉ có nghĩa là những quảng cảo trên trang web của chúng tôi sẽ không được điều chỉnh để phù hợp với sở thích hoặc thói quen của bạn nữa và người dùng có thể sẽ nhìn thấy những quảng cáo lặp đi lặp lại của chúng tôi'),
                Gap(),
                TitleContent('6. Chia sẻ và sử dụng thông tin'),
                Gap(),
                TitleContent(
                    'Việc chia sẽ và sử dụng thông tin. Chúng tôi có thể chia sẻ thông tin cá nhân của người dùng đối với bên thứ ba dưới một vài trường hợp sau đây:'),
                Gap(),
                DotLine(
                    "Chia sẻ và sử dụng cho việc marketing. Thông tin có thể được tiết lộ với mục đích marketing, quản lí và mục đích khác. Người dùng có thể lựa chọn huỷ bằng các phương pháp đã được nêu ở mục 5.0"),
                Gap(),
                DotLine(
                    "Chia sẻ và sử dụng cho một vài thông tin hiện trên trang. Một số thông tin cá nhân liên quan tới việc đánh giá có thể sẽ được tiết lộ (ví dụ: đánh giá, tên tài khoản đánh giá, ngày tháng..)"),
                Gap(),
                DotLine(
                    "Chia sẻ và sử dụng các dịch vụ và tính năng bên thứ ba - đồng thương hiệu. Trang web cũng có thể cung cấp các dịch vụ và tính năng ví dụ như sự kiện hoặc khuyến mãi mà chúng tôi kết hợp với bên thứ ba và có thể được lưu trữ và trên trang web và tổ chức bởi đối tác cùng nhãn hiệu. Đối tác cùng nhãn hiệu có trách nhiệm thông báo phương thức để người dùng có sự lựa chọn về việc không tham gia việc sử dụng thông tin cá nhân. Người dùng cần liên hệ trực tiếp đến các bên đồng thương hiệu và tuân thủ các chính sách mà bên thứ ba thiết lập"),
                Gap(),
                NormalContent(
                    "Về việc sử dụng thông tin, bên thứ ba có thể sử dụng thông tin cá nhân để liên hệ với người dùng trong trường hợp cần xác minh và điều kiện nếu người dùng là một trong những người chiến thắng trong các chương trình mà chúng tôi và bên thứ ba tổ chức"),
                Gap(),
                DotLine(
                    "Chia sẻ cho các nhà cung cấp dịch vụ vận hành trang. Chúng tôi có quyền chia sẻ thông tin dữ liệu cho các nhà cung cấp dịch vụ web (Operational Service Providers) với mục đích quản lý và vận hành trang web. Chúng tôi sử dụng các nhà cung cấp dịch vụ web cho mục đích xây dựng trang, vận hành nội dung, hoạt động, xây dựng tính năng và các dịch vụ khác mà chúng tôi mang tới người dùng"),
                Gap(),
                DotLine(
                    "Chia sẻ cho một vài bên thứ ba nhất định. Bổ sung về việc chia sẻ thông tin, chúng tôi sẽ cung cấp thông tin cá nhân của người dùng cho một số bên thứ ba nhất định trong các trường hợp hạn chế sau"),
                Gap(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      DotLine(
                          "Khi chúng tôi được yêu cầu bởi cơ quan chính phủ, toà án hoặc tổ chức có thẩm quyền của đất nước Việt Nam, nhằm đáp ứng phục vụ việc hầu toà, lệnh của toà án hoặc các thủ tục pháp lý như một phần của yêu cầu điều tra"),
                      Gap(),
                      DotLine(
                          "Nếu chúng tôi tin rằng hành động của bạn vi phạm bất kỳ luật, quy tắc, quy định nào hoặc thỏa thuận điều khoản sử dụng, bao gồm nhưng không giới hạn ở chính sách quyền riêng tư này hoặc điều khoản bổ sung mà chúng tôi đưa ra"),
                      Gap(),
                      DotLine(
                          "Liên quan đến chương trình khuyến mãi, khi cần thiết để quản lý chương trình khuyến mãi hoặc theo yêu cầu của luật, quy tắc hoặc quy định hiện hành (ví dụ: để cung cấp danh sách người chiến thắng hoặc lập hồ sơ cần thiết nếu thích hợp)"),
                      Gap(),
                      DotLine(
                          "Nếu bạn đồng ý chia sẻ Thông tin cá nhân của mình hoặc tiết lộ cho bên thứ ba để tiếp thị hoặc cho các mục đích khác, trong trường hợp đó, việc bên thứ ba sử dụng Thông tin cá nhân của bạn phải tuân theo chính sách quyền riêng tư của bên thứ ba"),
                      Gap(),
                      DotLine(
                          "Nếu, theo quyết định riêng của chúng tôi và chúng tôi tin rằng việc tiết lộ đó là cần thiết hoặc phù hợp:"),
                      Gap(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            DotLine(
                                "để điều tra hoặc giải quyết các vấn đề hoặc thắc mắc có thể xảy ra"),
                            Gap(),
                            DotLine(
                                "để bảo vệ hoạt động kinh doanh và tài sản của chúng tôi hoặc các quyền, tài sản hoặc sự an toàn của Rank Your UNi hoặc bất kỳ nhà cung cấp dịch vụ vận hành, người cấp phép, nhà cung cấp, Nhà quảng cáo, khách hàng, người dùng hoặc bất kỳ bên nào khác"),
                            Gap(),
                            DotLine(
                                "để hạn chế trách nhiệm pháp lý của chúng tôi"),
                            Gap(),
                            DotLine("để bảo vệ lợi ích của chúng tôi"),
                            Gap(),
                            DotLine(
                                "để thực thi chính sách quyền riêng tư này hoặc thỏa thuận điều khoản sử dụng hoặc để tuân thủ các nghĩa vụ pháp lý, quy định, kiểm toán và tuân thủ của chúng tôi hoặc các yêu cầu của cơ quan thực thi pháp luật hoặc các cơ quan chính phủ khác"),
                            Gap(),
                            DotLine(
                                "Trong trường hợp phá sản, sáp nhập, mua lại, bán, chuyển giao quyền kiểm soát, liên doanh hoặc kết hợp kinh doanh khác liên quan đến chúng tôi"),
                            Gap(),
                          ],
                        ),
                      ),
                      DotLine(
                          "Tiết lộ cho các danh nghiệp tiếp thị liên kết. Chúng tôi có thể chia sẻ thông tin với các doanh nghiệp tiếp thị liên kết hoặc cơ sở kinh doanh khác của Rank Your UNi. Chúng tôi làm điều này để cung cấp hoặc cải thiện dịch vụ"),
                      Gap(),

                    ],
                  ),
                ),
                NormalContent(
                    'Chia sẻ và tiết lộ thông tin không được xác định danh tính. Chúng tôi có thể chia sẻ Thông tin không xác định với hoặc tiết lộ Thông tin không xác định cho các bên thứ ba, nhưng chúng tôi không tiết lộ Thông tin cá nhân cho họ ngoại trừ những thông tin được mô tả trong Chính sách quyền riêng tư này'),
                Gap(),
                TitleContent(
                    '7. Chỉnh sửa, xoá một số thông tin, dữ liệu nhất định'),
                Gap(),
                DotLine(
                    'Đăng kí tài khoản. Nếu người dùng đăng kí tài khoản để sử dụng trang web của chúng tôi. Việc đăng kí tài khoản giúp người dùng có thể dễ dàng cập nhật hoặc xoá một số thông tin nhất định được cung cấp bởi người dùng tới trang web. Tuy nhiên, sẽ có một vài thông tin cá nhân cần thiết được sử dụng để kiểm tra rằng người dùng đủ điều kiện (ví dụ: ngày sinh, tuổi) sẽ không thể bị xoá nhưng có thể được sửa đổi khi thông tin được xác minh đầy đủ và chính xác'),
                Gap(),
                DotLine(
                    'Các sự lựa chọn khác. Đối với các tải khoản đăng kí của người dùng, với tư cách là thành viên đăng kí của RYU, chúng tôi có thể cung cấp các sự lựa chọn về việc họ nhận được một số thông báo nhất định và các có thể chia sẻ các hoạt động người dùng tham gia trên trang web'),
                Gap(),
                DotLine(
                    'Hạn chế. Một số thông tin nhất định được thu thập trong lúc người dùng tham gia vào các chương trình khuyến mãi hoặc dịch vụ của chúng tôi sẽ phải tuân theo các yêu cầu về việc lưu trữ thông tin, hồ sơ của người dùng và sẽ không bị xoá theo yêu câu của người dùng, trừ khi người dùng dưới 16 tuổi hoặc các trường hợp nhất định khác'),
                Gap(),
                DotLine(
                    'Những đối tượng không được khuyến khích sử dụng trang. Người dùng của chúng tôi được khuyến cáo phải ít nhất từ 17 tuổi để sử dụng trang. Nếu chúng tôi vô tình gửi email hoặc tin nhắn văn bản cho một số người dùng không đáp ứng về các yêu cầu về độ tuổi hoặc các điều kiện khác (người dưới 17 tuổi). Người bảo hộ (ví dụ: phụ huynh), có thể huỷ đăng kí hoặc lựa chọn không tham gia nhận email thông qua cơ chế huỷ đăng kí trong email hoặc tin nhắn hoặc các quy trình huỷ đăng kí tương tự mà chúng tôi nêu ở phía trên'),
                Gap(),
                NormalContent(
                    'Ngoài ra, việc chấm dứt tư cách thành viên do không đủ điều kiện về độ tuổi. Người dùng cần sử dụng thẻ căn cước để xác minh quyền truy cập trực tiếp vào tài khoản và làm theo các quy trình. Hãy liên hệ với chúng tôi qua trang web, tại phần liên hệ'),
                Gap(),
                TitleContent('8. Bảo vệ thông tin'),
                Gap(),
                NormalContent(
                    'Mặc dù các thông tin về dữ liệu trên mạng là không an toàn 100%, nhưng chúng tôi vẫn sử dụng các dịch vụ bảo vệ về mặt vật lý, điện tử, dữ liệu và các hoạt động thương mại để bảo vệ thông tin của bạn. Tuy nhiên, bất kể nỗ lực của chúng tôi và thiết bị người dùng sử dụng để truy cập trang đều có thể có khả năng bị tấn công với mục đích xấu từ bên thứ ba. Nhưng chúng tôi đảm bảo rằng các liên quan tới giao dịch online đều được bảo vệ'),
                Gap(),
                NormalContent(
                    'Hơn nữa, chúng tôi hạn chế quyền truy cập của nhân viên đối với trang web của chúng tôi. Những cá nhân được uỷ quyền cho việc xử lý thông tin sẽ chịu trách nhiệm về pháp luật hoặc bất kì các hình phạt khác nếu bị phát hiện vi phạm các tiêu chuẩn yêu cầu về bảo mật chúng tôi. Và chúng tôi yêu cầu các nhà cung cấp dịch vụ vận hành của chúng tôi tuân theo các tiêu chuẩn tương tự về bảo mật'),
                Gap(),
                NormalContent('Thuật ngữ Phishing:'),
                Gap(),
                DotLine(
                    'Là hình thức tấn công mạng mà kẻ tấn công giả mạo chúng tôi (RYU) để lừa đảo người dùng cung cấp thông tin cá nhân cho kẻ lừa đảo. Phương thức này thường được tin tặc thực hiện thông qua email và tin nhắn. Người dùng khi mở các email, hoặc đường link giả mạo này có thể sẽ được yêu cầu cung cấp các thông tin cá nhân nhạy cảm như: tài khoản & mật khẩu, mật khẩu giao dịch, thẻ tín dụng hoặc các thông tin quý giá khác'),
                Gap(),
                NormalContent(
                    'CHÚNG TÔI KHÔNG GỬI EMAIL YÊU CẦU BẠN CUNG CẤP HOẶC XÁC NHẬN CÁC THÔNG TIN LIÊN QUAN TỚI SỐ THẺ TÍN DỤNG, MẬT KHẨU CỦA NGƯỜI DÙNG!'),
                Gap(),
                NormalContent(
                    'Nếu bạn nhận được thông tin liên lạc qua email như vậy không làm theo. Vui lòng liên hệ với chúng tôi qua địa chỉ email rankyouruni@outlook.com'),
                Gap(),
                TitleContent(
                    '9. Chính sách bảo mật này giải thích các Rank Your UNi thu thập, sử dụng, chia sẻ dữ liệu cá nhân của bạn khi sử dụng trang web của chúng tôi hoặc tương tác với website. Dữ liệu cá nhân là bất kì thông tin nào về người dùng dùng để nhận dạng. Bao gồm các thông tin như:'),
                Gap(),
                DotLine('Tên, địa chỉ email'),
                Gap(),
                DotLine(
                    'Thông tin về thiết bị đăng nhập (IP, mã quốc gia, khu vực thành phố)'),
                Gap(),
                DotLine(
                    'Thông tin liên quan tới cách người dùng sử dụng hoặc tương tác với trang web và dịch vụ được cung cấp bởi chúng tôi'),
                Gap(),
                DotLine(
                    'Đối với những trường hợp liên kết tới các trang web hoặc ứng dụng không phải của Rank Your UNi, người dùng nên đọc chính sách bảo mật của riêng chúng'),
                Gap(),
                TitleContent('10. Các điều khoản phù hợp khác'),
                Gap(),
                DotLine(
                    'Thay đổi chính sách và quyền riêng tư. Chúng tôi hoàn toàn có quyền thay đổi, sửa đổi chính sách quyền riêng tư này bất kì lúc nào vì bất kì lý do gì mà không cần cập nhập hoặc thông báo trước cho người dùng. Những sửa đổi như vậy sẽ có hiệu lực ngay khi đăng và áp dụng với người dùng'),
                Gap(),
                DotLine(
                    'Chúng tôi sẽ hiển thị những thông báo về những thay đổi quan trọng trên trang chủ hoặc trang web hoặc email để thông báo cho người dùng đã được đăng kí về những thay đổi này'),
                Gap(),
                DotLine(
                    'Chúng tôi khuyến khích người dùng thường xuyên ghé thăm chính sách quyền riêng tư và thoả thuận điều khoản sử dụng để cập nhật những thông tin mới nhất'),
                Gap(),
                NormalContent(
                    'Có hiệu lực kể từ ngày 8, tháng 12, năm 2023'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
