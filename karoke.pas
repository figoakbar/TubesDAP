program karoke;
uses crt,sysutils;
const harga_super = 200000;
const harga_reguler = 100000;
type
    pelanggan = record
    nama_depan, nama_belakang, kelas_fasilitas : string;
    ruangan : integer;
    kupon : integer;
    biaya,jam,durasi : real;
    member : char;
end;
type Arrpel = array [1..40] of pelanggan;

var
    i,n,jml : integer;
    data_pelanggan : pelanggan;
    arr_pelanggan : Arrpel;
    depan,belakang : string;
    stop : integer;
    member_cari : char;
    filepelanggan : file of arrpel;
    filejml : file of integer;

    procedure input_admin ();
    var
        username: string = 'admin';
        password: string = 'hello';
        nama_admin : string;
        password_admin : string;
    begin
            repeat
                clrscr;
                write('username : ');
                readln(nama_admin);
                write('password : ');
                readln(password_admin);
                        if (nama_admin <> username) or (password_admin <> password) then
                        begin
                                writeln('username dan password anda salah');
                        end;
            until(nama_admin = username) and (password_admin = password);
            readln;
    end;

    procedure jadi_member(var tab_member : arrpel; var jml : integer);
    begin
        write('apakah anda tertarik menjadi member (Y/N) : ');
        readln(arr_pelanggan[jml].member);
           {if (arr_pelanggan[jml].member = 'y') or (arr_pelanggan[jml].member = 'Y') then begin
                   if arr_pelanggan[jml].kelas_fasilitas = 'super' then
                                begin
                                        arr_pelanggan[jml].biaya := harga_super*0.15;
                                        arr_pelanggan[jml].biaya:= harga_super - arr_pelanggan[jml].biaya;
                                end
                        else if arr_pelanggan[jml].kelas_fasilitas = 'regular'then
                                begin
                                        arr_pelanggan[jml].biaya := harga_reguler*0.15;
                                        arr_pelanggan[jml].biaya := harga_reguler - arr_pelanggan[jml].biaya;
                                 end
            end;}

            {else if (arr_pelanggan[jml].member = 'n') or (arr_pelanggan[jml].member = 'N') then
            begin
                 if  arr_pelanggan[jml].kelas_fasilitas = 'super' then
                            arr_pelanggan[jml].biaya := harga_super
                 else if arr_pelanggan[jml].kelas_fasilitas = 'regular' then
                                arr_pelanggan[jml].biaya := harga_reguler;
            end;}
            readln;

    end;

    procedure pemilihan_jam(var data : arrpel; var jml : integer);
    begin
        repeat
                write('masukan jam pesan : ');
                readln(arr_pelanggan[jml].jam);
                if (arr_pelanggan[jml].jam >=24) then
                        writeln('masukan jam lagi')
                else if (arr_pelanggan[jml].jam >= 23) or (arr_pelanggan[jml].jam <= 12) then
                        writeln('kami tutup');

        until(arr_pelanggan[jml].jam <= 22) and (arr_pelanggan[jml].jam >= 13);
        repeat
                write('sampai jam : ');
                readln(arr_pelanggan[jml].durasi);
                if (arr_pelanggan[jml].durasi >=24) then
                        writeln('masukan jam lagi')
                else if (arr_pelanggan[jml].durasi >= 23) or (arr_pelanggan[jml].durasi <= 12) then
                        writeln('kami tutup');

        until(arr_pelanggan[jml].durasi <= 22) and (arr_pelanggan[jml].durasi >= 13);
    end;

    procedure map_super ();
    begin
        clrscr;
        writeln('[*]=========================================[*]');
        writeln('[ ]                                         [ ]');
        writeln('[ ]           RUANGAN SUPER                 [ ]');
        writeln('[ ]           _____________                 [ ]');
        writeln;
            for i := 1 to 4 do begin
                write ('     |',i,'|   ');
            end;
    end;
    procedure map_reguler();
    begin
        clrscr;
        writeln('[*]=========================================[*]');
        writeln('[ ]                                         [ ]');
        writeln('[ ]           RUANGAN REGULAR               [ ]');
        writeln('[ ]           _______________               [ ]');
        writeln;
            for i := 1 to 6 do begin
                write('  |',i,'|  ');
            end;
    end;

    procedure punya_kupon(var data : arrpel; var jml : integer);
    begin
        write('masukan kupon yang anda punya : ');
        readln(arr_pelanggan[jml].kupon);
                if arr_pelanggan[jml].kupon >= 5 then begin
                        if arr_pelanggan[jml].kelas_fasilitas = 'super' then
                                begin
                                        arr_pelanggan[jml].biaya := harga_super*0.15;
                                        arr_pelanggan[jml].biaya:= harga_super - arr_pelanggan[jml].biaya;
                                            if arr_pelanggan[jml].durasi - arr_pelanggan[jml].jam >= 2 then
                                                arr_pelanggan[jml].biaya := arr_pelanggan[jml].biaya*(arr_pelanggan[jml].durasi - arr_pelanggan[jml].jam);
                                end
                        else if arr_pelanggan[jml].kelas_fasilitas = 'regular'then
                                begin
                                        arr_pelanggan[jml].biaya := harga_reguler*0.15;
                                        arr_pelanggan[jml].biaya := harga_reguler - arr_pelanggan[jml].biaya;
                                             if arr_pelanggan[jml].durasi - arr_pelanggan[jml].jam >= 2 then
                                                arr_pelanggan[jml].biaya := arr_pelanggan[jml].biaya*(arr_pelanggan[jml].durasi - arr_pelanggan[jml].jam);
                                 end;
                end
                else begin
                    if  arr_pelanggan[jml].kelas_fasilitas = 'super' then begin
                            arr_pelanggan[jml].biaya := harga_super;
                                 if arr_pelanggan[jml].durasi - arr_pelanggan[jml].jam >= 2 then
                                    arr_pelanggan[jml].biaya := harga_super*(arr_pelanggan[jml].durasi - arr_pelanggan[jml].jam);
                    end

                    else if arr_pelanggan[jml].kelas_fasilitas = 'regular' then begin
                                arr_pelanggan[jml].biaya := harga_reguler;
                                     if arr_pelanggan[jml].durasi - arr_pelanggan[jml].jam >= 2 then
                                            arr_pelanggan[jml].biaya := harga_reguler*(arr_pelanggan[jml].durasi - arr_pelanggan[jml].jam);
                                end
                end;
    end;

    procedure terima_kasih();
    begin
        clrscr;
        writeln('===================================================');
        writeln('=            terima kasih telah memesan           =');
        writeln('===================================================');
        readln;
    end;

    procedure input_super(var data : arrpel; var jml : integer);
    begin
        map_super();
        writeln;
        writeln('=============================================');
        write('pilih ruangan : ');
        readln(arr_pelanggan[jml].ruangan);
        pemilihan_jam(arr_pelanggan,jml);
        punya_kupon(arr_pelanggan,jml);
        writeln;
        writeln('tarif : ',arr_pelanggan[jml].biaya:0:0);
            if arr_pelanggan[jml].kupon >= 5 then
                writeln('kupon yang anda punya sekarang : ',arr_pelanggan[jml].kupon - 5)
            else if arr_pelanggan[jml].kupon < 5 then
                writeln('kupon yang anda miliki tidak cukup');
        writeln;
        jadi_member(arr_pelanggan,jml);
        readln;
        terima_kasih();

    end;
    procedure input_reguler(var data : arrpel; var jml : integer);
    begin
        map_reguler;
        writeln;
        writeln('==============================================');
        write('pilih ruangan : ');
        readln(arr_pelanggan[jml].ruangan);
        pemilihan_jam (arr_pelanggan,jml);
        punya_kupon(arr_pelanggan,jml);
        writeln;
        writeln('tarif : ',arr_pelanggan[jml].biaya:0:0);
            if arr_pelanggan[jml].kupon >= 5 then
                writeln('kupon yang anda punya sekarang : ',arr_pelanggan[jml].kupon - 5)
            else if arr_pelanggan[jml].kupon < 5 then
                writeln('kupon yang anda miliki tidak cukup');
            writeln;
            jadi_member(arr_pelanggan,jml);
        readln;
        terima_kasih();
    end;

    procedure booking_tempat(var data : arrpel; var jml : integer);
    begin
        clrscr;
        writeln('[#]================booking tempat karoke==================[#]');
        write('nama depan : ');
        readln(arr_pelanggan[jml].nama_depan);
        write('nama belakang : ');
        readln(arr_pelanggan[jml].nama_belakang);
        write('kelas fasilitas(super/regular) : ');
        readln(arr_pelanggan[jml].kelas_fasilitas);
        if arr_pelanggan[jml].kelas_fasilitas = 'super' then
            input_super(arr_pelanggan,jml)
        else if arr_pelanggan[jml].kelas_fasilitas = 'regular' then
                input_reguler(arr_pelanggan,jml);
        jml := jml + 1;
        writeln('[#]=======================================================[#]');

    end;

    procedure output (var data : arrpel ;n : integer );
    var
        i : integer;
    begin
        clrscr;
        if arr_pelanggan[1].nama_belakang = '' then
            write('data pelanggan belum diinput')
        else
        begin
        for i := 1 to n do begin
        if arr_pelanggan[i].ruangan <> 0 then begin
        writeln('[#]=======================================================[#]');
        writeln('nama lengkap  : ',arr_pelanggan[i].nama_depan,' ',arr_pelanggan[i].nama_belakang);
        writeln('kelas : ',arr_pelanggan[i].kelas_fasilitas);
        writeln('ruangan : ',arr_pelanggan[i].ruangan);
        writeln('jam pemesanan : ',arr_pelanggan[i].jam:0:2);
        writeln('durasi karoke : ',arr_pelanggan[i].durasi - arr_pelanggan[i].jam:0:0,' jam');
        if arr_pelanggan[i].kelas_fasilitas = 'super' then
            writeln('tarif : ',arr_pelanggan[i].biaya:0:0)
        else if arr_pelanggan[i].kelas_fasilitas = 'regular' then
            writeln('tarif : ',arr_pelanggan[i].biaya:0:0);
        if arr_pelanggan[i].kupon >= 5 then
                writeln('kupon yang anda punya sekarang : ',arr_pelanggan[i].kupon - 5)
        else if arr_pelanggan[i].kupon < 5 then
                writeln('kupon yang anda miliki tidak cukup');
        writeln('member : ',arr_pelanggan[i].member);
        end;
        end;
        end;
        readln;
    end;

   procedure cari_data(var data : arrpel; depan,belakang : string ; jml : integer);
    begin
        clrscr;
        write('nama depan : ');
        readln(depan);
        write('nama belakang : ');
        readln(belakang);
        i := 1;
            while (depan <> arr_pelanggan[i].nama_depan) and (belakang <> arr_pelanggan[i].nama_belakang) and (i < jml) do begin
                i := i + 1
            end;
            if (depan = arr_pelanggan[i].nama_depan) and (belakang = arr_pelanggan[i].nama_belakang) then begin
                  writeln;
                  writeln('========================================================');
                  writeln;
                  writeln('kelas : ',arr_pelanggan[i].kelas_fasilitas);
                  writeln('ruangan : ',arr_pelanggan[i].ruangan);
                  writeln('jam pemesanan : ',arr_pelanggan[i].jam:0:2);
                  writeln('durasi karoke : ',arr_pelanggan[i].durasi - arr_pelanggan[i].jam:0:0,' jam');
                        if arr_pelanggan[i].kelas_fasilitas = 'super' then
                                writeln('tarif : ',arr_pelanggan[i].biaya:0:0)
                        else if arr_pelanggan[i].kelas_fasilitas = 'regular' then
                                writeln('tarif : ',arr_pelanggan[i].biaya:0:0);
                                        if arr_pelanggan[i].kupon >= 5 then
                                                writeln('kupon yang anda punya sekarang : ',arr_pelanggan[i].kupon - 5)
                                        else if arr_pelanggan[i].kupon < 5 then
                                                writeln('kupon yang anda miliki tidak cukup');

            end
            else
            if (i > jml)then
            begin
                write('data tidak ditemukan');
            end;
            readln;
    end;

    procedure search_member(var data : arrpel; member_cari : char; jml : integer);
    begin
        clrscr;
        write('code member(y/n) : ');
        readln(member_cari);
        i := 1;
            while (member_cari <> arr_pelanggan[i].member) and (i < jml) do begin
                i := i + 1;
            end;
                if (member_cari = arr_pelanggan[i].member) then begin
                     for i := 1 to jml do begin
                        if arr_pelanggan[i].member = 'y' then begin
                            writeln('[#]=======================================================[#]');
                            writeln('nama lengkap  : ',arr_pelanggan[i].nama_depan,' ',arr_pelanggan[i].nama_belakang);
                        end;
                    end;
                end
                else
                    if (i > jml) then
                    begin
                        write('data tidak ditemukan');
                   end;
            readln;
    end;

    procedure sorting_nama(var arr_pelanggan : arrpel; n : integer);
    {menggunakan bubble sort}
    var
        i : integer;
        pass : integer;
        temp : pelanggan;
    begin
        for pass := 1 to n - 1 do
        begin
            for i := 1 to n do begin
                if arr_pelanggan[i].nama_depan < arr_pelanggan[i+1].nama_depan then begin
                    temp := arr_pelanggan[pass];
                    arr_pelanggan[pass] := arr_pelanggan[pass+1];
                    arr_pelanggan[pass + 1] := temp;
                end;
            end;
        end;
        output(arr_pelanggan,jml);
    end;

    procedure sorting_biaya(var arr_pelanggan : arrpel; n : integer);
    {menggunakan selection sort}
    var
        i, i_max : integer;
        pass : integer;
        temp : pelanggan;
    begin
        for pass := 1 to n-1 do begin
            i_max := pass;
            for i := pass + 1 to n do begin
                if arr_pelanggan[i].biaya > arr_pelanggan[i_max].biaya then begin
                    i_max := i;
                end;
            end;
        temp := arr_pelanggan[pass];
        arr_pelanggan[pass] := arr_pelanggan[i_max];
        arr_pelanggan[i_max] := temp;
        end;
        output(arr_pelanggan,jml)
    end;

    procedure sorting_jam(var arr_pelanggan : arrpel; n : integer);
    {menggunakan insertion sort}
    var
        i,pass : integer;
        temp : pelanggan;
        temp_jam : real;
    begin
        for pass := 1 to n - 1 do begin
            i := pass + 1;
            temp := arr_pelanggan[i];
            temp_jam := arr_pelanggan[i].jam;
                while (temp_jam > arr_pelanggan[i-1].jam) and (i > 1) do
                begin
                    arr_pelanggan[i] := arr_pelanggan[i-1];
                    i := i - 1;
                end;
            arr_pelanggan[i] := temp;
        end;
        output(arr_pelanggan,jml);
    end;


    procedure hapus_data(var data : arrpel;var i : integer);
    var
        y,pass : integer;
        hapus_nama : string;
    begin
        clrscr;
        write('Nama pelanggan yang data nya ingin di hapus : ');
        readln(hapus_nama);
        y := 1;
        while(hapus_nama <> arr_pelanggan[y].nama_depan) and (y < i) do begin
            y := y + 1;
        end;
        if (hapus_nama = arr_pelanggan[y].nama_depan) then begin
            for pass := y + 1 to i do begin
                arr_pelanggan[y] := arr_pelanggan[y+1];
                y := y + 1;
            end;
            arr_pelanggan[y].nama_depan := '';
            i := i + 1;
            writeln;
            writeln('data telah terhapus');
        end;
        readln;
    end;

    procedure edit_data(var data : arrpel; i : integer);
    var
        ubah : integer;
    begin
        //admin tidak boleh mengubah durasi karoke pelanggan
        clrscr;
        output(arr_pelanggan,jml);
        writeln;
        write('pilih data yang ingin diubah : ');
        readln(ubah);
        writeln;
        write('pilih ruangan : ');
        readln(arr_pelanggan[ubah].ruangan);
        write('masukan jam pesan : ');
        readln(arr_pelanggan[ubah].jam);
         write('sampai jam : ');
         readln(arr_pelanggan[ubah].durasi);
    readln;
    end;


    procedure menu_pelanggan();
    var
        pilih : integer;
    begin
        clrscr;
        writeln('====================================================================');
        writeln('=                                                                  =');
        writeln('=                   1. Data pemesan ruangan                        =');
        writeln('=                   2. pengurutan nama                             =');
        writeln('=                   3. pengurutan tarif pelanggan                  =');
        writeln('=                   4. pengurutan jam pesan                        =');
        writeln('=                   5. data member                                 =');
        writeln('=                                                                  =');
        writeln('====================================================================');
        write('pilih menu : ');
        readln(pilih);
        case pilih of
            1 : output(arr_pelanggan,jml);
            2 : sorting_nama(arr_pelanggan,jml);
            3 : sorting_biaya(arr_pelanggan,jml);
            4 : sorting_jam(arr_pelanggan,jml);
            5 : search_member(arr_pelanggan,member_cari,jml);
        end;
        readln;

    end;


    procedure menu_admin ();
    var
        pilih : integer;
    begin
    input_admin();
    clrscr;
    writeln('=========================================================================');
    writeln('=                                                                       =');
    writeln('=                       1. data pelanggan                               =');
    writeln('=                       2. menghapus data                               =');
    writeln('=                       3. mengedit data                                =');
    writeln('=                                                                       =');
    writeln('=========================================================================');
    write('pilih menu : ');
    readln(pilih);
        case pilih of
            1 : menu_pelanggan;
            2 : hapus_data(arr_pelanggan,jml);
            3 : edit_data(arr_pelanggan,jml);
        end;
        readln;
    end;

   procedure menu_utama();
    var
        pilihan : integer;
    begin
        clrscr;
        writeln('                          ===============================================================================================      ');
        writeln('                          =                              SELAMAT DATANG DI EMERALD CITY                                 =      ');
        writeln('                          =                                         KAROKE                                              =      ');
        writeln('                          =                                                                                             =      ');
        writeln('                          =                                    1. Admin                                                 =      ');
        writeln('                          =                                    2. Booking tempat                                        =      ');
        writeln('                          =                                    3. Cetak data                                            =      ');
        writeln('                          =                                                                                             =      ');
        writeln('                          =                                                                               0 : exit      =      ');
        writeln('                          ===============================================================================================      ');
        writeln;

        write('pilih menu : ');
        readln(pilihan);
        case pilihan of
            1 : menu_admin;
            2 : booking_tempat(arr_pelanggan,jml);
            3 : cari_data(arr_pelanggan,depan,belakang,jml);
            0 : stop := 1;
        end;
    end;
begin
    if FileExists('filearraypel.dat') then
	begin
		assign(filepelanggan, 'filearraypel.dat');
		reset(filepelanggan);
	end
	else
	begin
		assign(filepelanggan, 'filearraypel.dat');
		rewrite(filepelanggan);
		reset(filepelanggan);
	end;
	while not eof(filepelanggan) do
	begin
		read(filepelanggan, arr_pelanggan);
	end;
    clrscr;
    jml := 1;
    stop := 0;
    repeat
        menu_utama();
    until stop = 1;
    Close(filepelanggan);

end.
