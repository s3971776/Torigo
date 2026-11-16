-- Dữ liệu ban đầu của web Torigo. Chạy sau schema.sql. Chạy lại không ghi đè dữ liệu đã có.

insert into site_settings (id, data) values (1, '{"name":"Torigo","tagline":"Mang đến âm thanh mà bạn muốn.","description":"Torigo: thay dây, setup, vệ sinh, thay nut, điện, refret và repaint đàn guitar tại TP. HCM.","phone":"0938 616 817","zalo":"https://zalo.me/0938616817","address":"127/137A Điện Biên Phủ, phường Tân Định, TP. HCM","mapUrl":"https://www.google.com/maps/search/?api=1&query=127%2F137A+%C4%90i%E1%BB%87n+Bi%C3%AAn+Ph%E1%BB%A7%2C+T%C3%A2n+%C4%90%E1%BB%8Bnh%2C+TP.+HCM","hours":[["Thứ 2 – Thứ 6","9:00 – 19:00"],["Thứ 7","9:00 – 17:00"],["Chủ nhật","Nghỉ"]],"announcement":{"text":"Mua dây Olympia Artisan hoặc Elixir tại shop, thay dây miễn phí","link":"/dich-vu/#setup"},"heroPhoto":"/src/assets/photos/09643.jpg"}'::jsonb) on conflict (id) do nothing;

insert into services (slug, sort, name, short, description, price, photo, cols, rows, notes, callout) values
  ('setup', 1, 'Thay dây & Setup', 'Thay dây mới và cân chỉnh action, intonation theo từng loại ngựa đàn.', 'Thay dây mới và cân chỉnh lại đàn. Giá tính theo loại ngựa đàn, vì ngựa nhún hai chiều, Evertune và Bigsby mất nhiều công hơn. Thay dây và setup được tính riêng, bạn có thể chọn một trong hai hoặc cả hai.', '50.000 đ', '/src/assets/photos/09595.jpg', '["Loại ngựa đàn","Thay dây","Setup"]'::jsonb, '[["Floating Bridge / Fixed / Nhún 1 chiều","50.000","50.000"],["Nhún 2 chiều / Evertune / Bigsby","100.000","100.000"]]'::jsonb, null, '{"label":"Ưu đãi dây đàn","title":"Mua dây tại shop, thay dây miễn phí!","text":"Áp dụng khi mua dây Olympia Artisan hoặc Elixir tại shop.","rows":[["Floating / Fixed / Nhún 1 chiều","Miễn phí"],["Nhún 2 chiều / Evertune / Bigsby","Giảm 50.000"]]}'::jsonb),
  ('ve-sinh', 2, 'Vệ sinh', 'Làm sạch đàn theo gói cơ bản hoặc chuyên sâu.', 'Vệ sinh đàn theo hai mức: gói cơ bản cho đàn dùng thường xuyên, gói chuyên sâu cho đàn lâu ngày chưa được chăm sóc. Giá gói chuyên sâu tùy tình trạng đàn.', '100.000 đ', '/src/assets/photos/09646.jpg', null, '[["Cơ bản","100.000"],["Chuyên sâu","200.000 – 300.000"]]'::jsonb, null, null),
  ('nut', 3, 'Thay nut', 'Thay lược đàn bằng xương hoặc TUSQ.', 'Thay lược đàn khi lược mòn, nứt hoặc rãnh dây quá sâu gây rè dây buông. Có lược xương và TUSQ; giá TUSQ nut báo theo từng cây đàn.', '150.000 đ', '/src/assets/photos/09644.jpg', null, '[["Lược xương","150.000"],["TUSQ nut","Liên hệ"]]'::jsonb, null, null),
  ('dien', 4, 'Điện & linh kiện', 'Thay pot, switch, jack hoặc làm lại toàn bộ mạch.', 'Thay pot, switch, jack hỏng hoặc đi lại toàn bộ mạch, theo sơ đồ cơ bản hoặc theo yêu cầu riêng của bạn. Giá là tiền công, chưa bao gồm linh kiện.', '100.000 đ', '/src/assets/photos/09630.jpg', null, '[["Thay pot, switch, jack","100.000"],["Làm toàn mạch cơ bản","200.000"],["Làm toàn mạch theo yêu cầu","250.000 – 400.000"]]'::jsonb, '["Chưa bao gồm linh kiện."]'::jsonb, null),
  ('refret', 5, 'Refret', 'Thay toàn bộ phím, nickel Sintoms hoặc stainless Schaller.', 'Thay toàn bộ phím khi phím đã mòn. Bạn chọn phím nickel của Sintoms hoặc phím stainless của Schaller. Cần đàn maple có phụ thu.', '1.800.000 đ', '/src/assets/photos/09631.jpg', null, '[["Phím Nickel (Sintoms)","1.800.000"],["Phím Stainless (Schaller)","2.500.000"],["Phụ thu cần đàn Maple (Maple neck)","+200.000"]]'::jsonb, null, null),
  ('repaint', 6, 'Repaint', 'Sơn lại đàn với finish satin, matte hoặc glossy, có hiệu ứng sparkle.', 'Sơn lại đàn với finish satin, matte hoặc glossy. Giá tùy finish và việc sơn phủ mới hay phải xả lớp sơn cũ. Hiệu ứng sparkle báo giá riêng.', '800.000 đ', '/src/assets/photos/09629.jpg', null, '[["Finish: Satin / Matte / Glossy","800.000 – 3.000.000"],["Hiệu ứng: Sparkle","Liên hệ"]]'::jsonb, '["Giá tùy finish, sơn phủ mới hoặc xả sơn cũ.","Sparkle chỉ dành cho glossy finish."]'::jsonb, '{"label":"Giải thích","title":"Vì sao nhũ chỉ đi với Glossy?","text":"Hạt nhũ cần được “ủ” dưới nhiều lớp bóng, chà nhám và đánh bóng từng lớp thì mới phẳng mịn và lấp lánh có chiều sâu. Lớp Matte hay Satin mỏng và mờ, nhũ sẽ bị xỉn và sần tay, nên Torigo chỉ nhận làm nhũ cùng gói Glossy để cây đàn của bạn đẹp trọn vẹn nhất nhé!"}'::jsonb)
on conflict (slug) do nothing;

insert into gallery (sort, photo, title, service)
select * from (values
  (1, '/src/assets/photos/09597.jpg', 'Stratocaster HSS đỏ rượu', 'setup'),
  (2, '/src/assets/photos/09615.jpg', 'Jaguar, cận cảnh pickup', 'dien'),
  (3, '/src/assets/photos/09602.jpg', 'Mặt sau headstock, bộ khóa', 'nut'),
  (4, '/src/assets/photos/09606.jpg', 'Mặt lưng Stratocaster', 'repaint'),
  (5, '/src/assets/photos/09637.jpg', 'Stratocaster bên sofa', 've-sinh'),
  (6, '/src/assets/photos/09662.jpg', 'Headstock và mặt phím Jaguar', 'refret'),
  (7, '/src/assets/photos/09599.jpg', 'Stratocaster HSS, góc nghiêng', 'setup'),
  (8, '/src/assets/photos/09633.jpg', 'Cụm công tắc Jaguar', 'dien'),
  (9, '/src/assets/photos/09668.jpg', 'Jaguar đỏ trong case', 'repaint'),
  (10, '/src/assets/photos/09634.jpg', 'Headstock Jaguar đỏ', 'nut'),
  (11, '/src/assets/photos/09640.jpg', 'Pickguard pearl và ngựa đàn', 've-sinh'),
  (12, '/src/assets/photos/09663.jpg', 'Jaguar, pickguard và cần đàn', 'refret'),
  (13, '/src/assets/photos/09652.jpg', 'Stratocaster trong case', 'setup'),
  (14, '/src/assets/photos/09660.jpg', 'Jaguar đỏ, toàn thân', 'repaint')
) v where not exists (select 1 from gallery);

insert into posts (slug, title, description, date, service, cover, body) values
  ('bao-quan-dan-khi-hau-viet-nam', 'Bảo quản guitar điện trong khí hậu Việt Nam', 'Độ ẩm cao và nhiệt độ thay đổi ảnh hưởng thế nào đến cần đàn, phím và phần điện.', '2026-11-03', 've-sinh', '/src/assets/photos/09653.jpg', 'Gỗ hút và nhả ẩm liên tục. Ở Việt Nam, độ ẩm mùa mưa và mùa nồm có thể vượt 85%, đủ để cần đàn đổi độ cong chỉ sau vài tuần.

## Độ ẩm lý tưởng

Giữ đàn ở khoảng 45 – 55%. Một túi hút ẩm trong bao đàn và một ẩm kế nhỏ là đủ cho phần lớn người chơi.

## Những việc nên làm

- Lau dây và mặt phím sau khi chơi, mồ hôi làm dây gỉ và phím xỉn rất nhanh.
- Cất đàn trong bao hoặc case khi không chơi nhiều ngày.
- Tránh để đàn sát tường ẩm, cạnh cửa sổ nắng hoặc trong cốp xe.

## Những việc không nên

Không để đàn trước luồng gió máy lạnh. Không nới hết dây khi cất ngắn ngày: cần đàn được thiết kế để chịu lực căng dây, thay đổi đột ngột mới gây hại.

## Khi nào cần mang ra xưởng

Đầu phím lòi ra cạnh cần, action đổi rõ sau mùa mưa, hoặc xuất hiện vết nứt sơn ở gót cần là lúc nên để thợ kiểm tra.'),
  ('chon-pickup', 'Chọn pickup thế nào cho đúng dòng nhạc', 'Single coil, humbucker, P90 khác nhau ra sao và khi nào nên thay pickup.', '2026-10-27', 'dien', '/src/assets/photos/09628.jpg', 'Pickup quyết định phần lớn màu tiếng của cây đàn điện. Thay pickup là cách nâng cấp rõ rệt nhất, nhưng chỉ khi bạn biết mình đang thiếu gì.

## Single coil

Tiếng sáng, rõ nốt, hợp funk, blues, pop. Nhược điểm là dễ nhiễu ù, nhất là khi chơi gain cao.

## Humbucker

Hai cuộn dây khử nhiễu, tiếng dày và mạnh hơn. Hợp rock, metal, jazz. Có thể đi dây **coil split** để lấy thêm tiếng gần giống single coil.

## P90

Nằm giữa hai loại trên: dày hơn single coil, gắt và thô hơn humbucker. Hợp garage rock, blues.

## Trước khi thay, hãy kiểm tra

- Chiều cao pickup: chỉnh sai làm tiếng mỏng hoặc đục, và chỉnh lại không tốn tiền linh kiện.
- Giá trị pot: 250k cho single coil, 500k cho humbucker là điểm bắt đầu phổ biến.
- Khoang đàn có vừa pickup mới không.'),
  ('dau-hieu-dan-can-di-sua', '5 dấu hiệu cây guitar điện của bạn cần đi sửa', 'Rè dây, action cao, lệch intonation và những dấu hiệu khác cho thấy đàn cần được setup lại.', '2026-11-10', 'setup', '/src/assets/photos/09665.jpg', 'Đàn guitar điện thay đổi theo thời tiết, theo dây và theo cách bạn chơi. Dưới đây là năm dấu hiệu dễ nhận ra nhất.

## 1. Rè dây ở một vài phím

Nếu chỉ rè ở vài vị trí, nguyên nhân thường là phím mòn không đều hoặc cần bị cong ngược. Rè toàn bộ cần thì thường do action quá thấp.

## 2. Action cao, bấm mỏi tay

Dây cách mặt phím quá xa làm bạn phải bấm mạnh, nốt dễ bị phô. Đo ở phím 12: trên khoảng 2 mm với dây 1 là đáng để chỉnh.

## 3. Lên dây đúng nhưng bấm phím cao vẫn sai

Đây là lệch **intonation**. So nốt bấm ở phím 12 với harmonic phím 12: nếu lệch, cần chỉnh lại saddle.

## 4. Cần đàn cong thấy bằng mắt

Nhìn dọc cần từ đầu đàn. Cần võng nhiều hoặc cong ngược đều cần chỉnh truss rod, và không nên tự vặn nếu chưa quen.

## 5. Tiếng ù, lẹt xẹt khi vặn núm

Pot bẩn, jack lỏng hoặc dây mass đứt. Việc này thuộc phần điện và thường sửa được trong ngày.')
on conflict (slug) do nothing;
