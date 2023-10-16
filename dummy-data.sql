INSERT INTO master_role (name) VALUES
('Admin'),
('Guru Mapel'),
('Wali Kelas'),
('Siswa');

INSERT INTO master_kelas (name) VALUES
('Kelas 1 A'),
('Kelas 1 B'),
('Kelas 2 A'),
('Kelas 2 B');

INSERT INTO master_mapel(name) VALUES
('Ilmu Pengetahuan Sosial'),
('Ilmu Pengetahuan Alam'),
('Matematika');

INSERT INTO master_ekskul(name) VALUES
('Silat'),
('Taekwondo'),
('Drumband');

INSERT INTO user(username, password, nip, fullname, address) VALUES
('admin@mail.com', 'admin12345678', null, 'Super Admin', 'Address admin'),

('sukardi@mail.com', 'admin12345678', '1234567', 'Sukardi', 'Address sukardi'),
('suparman@mail.com', 'admin12345678', '234567', 'Suparman', 'Address suparman'),
('alex@mail.com', 'admin12345678', '345678', 'Alex', 'Address alex'),
('mikha@mail.com', 'admin12345678', '456789', 'Mikha', 'Address mikha'),
('yeni@mail.com', 'admin12345678', '172631', 'Yeni', 'Address yeni'),
('freya@mail.com', 'admin12345678', '187273', 'Freya', 'Address freya'),

('marsha@mail.com', 'admin12345678', '1928172', 'Marsha', 'Address marsha'),
('cepio@mail.com', 'admin12345678', '1878271', 'Fiony', 'Address fiony'),
('kathrina@mail.com', 'admin12345678', '291982', 'Atin', 'Address atin'),
('ella@mail.com', 'admin12345678', '1829891', 'Ella', 'Address ella');


INSERT INTO user(username, password, nik, fullname, address) VALUES
('chika@mail.com', 'admin12345678', '123112', 'Chika', 'Address chika'),
('zee@mail.com', 'admin12345678', '123112', 'Zee', 'Address zee'),
('adel@mail.com', 'admin12345678', '1238382', 'Adel', 'Address adel'),
('ashel@mail.com', 'admin12345678', '182718927', 'Ashel', 'Address ashel'),
('jesslyn@mail.com', 'admin12345678', '981298129', 'Jesslyn', 'Address jesslyn'),
('shani@mail.com', 'admin12345678', '1828192', 'Shani', 'Address shani'),
('gracia@mail.com', 'admin12345678', '1829281', 'Gracia', 'Address gracia'),
('gita@mail.com', 'admin12345678', '1289128', 'Gita', 'Address gita');

INSERT INTO user_role(id_user, id_role) VALUES
(1, 1),

(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),

(8, 3),
(9, 3),
(10, 3),
(11, 3),

(12, 4),
(13, 4),
(14, 4),
(15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 4);

INSERT INTO student_kelas(id_kelas, id_user) VALUES
(1, 12),
(1, 13),
(2, 14),
(2, 15),
(3, 16),
(3, 17),
(4, 18),
(4, 19);


INSERT INTO mapping_mapel(id_user, id_mapel, id_kelas, semester, tahun) VALUES
(2, 1, 1, '1', '2023'),
(2, 1, 2, '1', '2023'),
(3, 1, 3, '1', '2023'),
(3, 1, 4, '1', '2023'),
(4, 2, 1, '1', '2023'),
(4, 2, 2, '1', '2023'),
(5, 2, 3, '1', '2023'),
(5, 2, 4, '1', '2023'),
(6, 3, 1, '1', '2023'),
(6, 3, 2, '1', '2023'),
(7, 3, 3, '1', '2023'),
(7, 3, 4, '1', '2023');

INSERT INTO mapel_report(id_mapping_mapel, id_user, nilai) VALUES
(1, 12, 60),
(5, 12, 70),
(9, 12, 80),
(1, 13, 80),
(5, 13, 60),
(9, 13, 50),
(2, 14, 60),
(6, 14, 60),
(10, 14, 50),
(2, 15, 100),
(6, 15, 100),
(10, 15, 50),
(3, 16, 50),
(7, 16, 70),
(11, 16, 50),
(3, 17, 50),
(7, 17, 70),
(11, 17, 50),
(4, 18, 70),
(8, 18, 80),
(12, 18, 90),
(4, 19, 80),
(8, 19, 90),
(12, 19, 90);

INSERT INTO mapping_ekskul(id_user, id_ekskul, tahun, semester) VALUES
(12, 1, '2023', '1'),
(13, 2, '2023', '1'),
(14, 3, '2023', '1');

INSERT INTO ekskul_report(id_mapping_ekskul, nilai) VALUES
(1, 70),
(2, 900),
(3, 80);

CREATE OR REPLACE VIEW user_role_view AS SELECT
    USER.id,
    USER.username,
    USER.password,
    USER.fullname,
    master_role.id AS role_id,
    master_role.name as role
FROM
    user_role
INNER JOIN USER ON user_role.id_user = USER.id
INNER JOIN master_role ON user_role.id_role = master_role.id
ORDER BY
    master_role.id;

CREATE OR REPLACE VIEW mapel_view AS
SELECT
    mapping_mapel.id,
    master_mapel.name AS mapel,
    mapping_mapel.tahun,
    mapping_mapel.semester,
    mapping_mapel.kkm,
    USER.fullname AS pengajar,
    master_kelas.name AS kelas
FROM
    mapping_mapel
INNER JOIN USER ON mapping_mapel.id_user = USER.id
INNER JOIN master_mapel ON mapping_mapel.id_mapel = master_mapel.id
INNER JOIN master_kelas ON mapping_mapel.id_kelas = master_kelas.id
ORDER BY
    mapping_mapel.id;

CREATE OR REPLACE VIEW ekskul_view AS
SELECT
    mapping_ekskul.id,
    master_ekskul.name AS ekskul,
    mapping_ekskul.tahun,
    mapping_ekskul.semester,
    USER.fullname AS siswa,
    USER.id AS id_siswa,
    master_kelas.name AS kelas
FROM
    mapping_ekskul
INNER JOIN USER ON mapping_ekskul.id_user = USER.id
INNER JOIN master_ekskul ON mapping_ekskul.id_ekskul = master_ekskul.id
INNER JOIN student_kelas ON mapping_ekskul.id_user = student_kelas.id_user
INNER JOIN master_kelas ON student_kelas.id_kelas = master_kelas.id
ORDER BY
    mapping_ekskul.id;

CREATE OR REPLACE VIEW raport_view AS
SELECT
    data.*
FROM
    (
    SELECT
        'mapel' AS type,
        mapel_view.mapel AS name,
        mapel_view.tahun,
        mapel_view.semester,
        mapel_view.pengajar,
        mapel_view.kelas,
        mapel_view.kkm,
        USER.id AS id_siswa,
        USER.fullname AS nama_siswa,
        mapel_report.nilai
    FROM
        mapel_report
    INNER JOIN USER ON mapel_report.id_user = USER.id
    INNER JOIN mapel_view ON mapel_report.id_mapping_mapel = mapel_view.id
    UNION ALL
SELECT
    'ekskul' AS type,
    ekskul_view.ekskul AS name,
    ekskul_view.tahun,
    ekskul_view.semester,
    NULL AS pengajar,
    ekskul_view.kelas,
    NULL AS kkm,
    ekskul_view.id_siswa,
    ekskul_view.siswa AS nama_siswa,
    ekskul_report.nilai
FROM
    ekskul_report
INNER JOIN ekskul_view ON ekskul_report.id_mapping_ekskul = ekskul_view.id
) AS DATA;