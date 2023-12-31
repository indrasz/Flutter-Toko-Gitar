String baseUrl = 'http://172.20.10.12:5001';

//AUTH
String urlRegister = '$baseUrl/user/register';
String urlLogin = '$baseUrl/user/login';

//Crud Gitar
String inputGitar = '$baseUrl/gitar/create';
String editGitar = '$baseUrl/gitar/edit';
String getAllGitar = '$baseUrl/gitar/getAll';
String hapusGitar = '$baseUrl/gitar/hapus';
String getByIdGitar = '$baseUrl/gitar/getbyid';

//Transaksi
String createTransaksi = '$baseUrl/transaksi/create';
String getTransaksiUser = '$baseUrl/transaksi/getbyiduser';
String getTransaksiUserLimit = '$baseUrl/transaksi/getbyiduserlimit';
String uploadBuktiPembayaran = '$baseUrl/transaksi/upload-bukti';
