CREATE TYPE response_status AS ENUM ('Не просмотрен', 'Просмотрен', 'Приглашение', 'Отказ');

CREATE TYPE vacancy_status AS ENUM ('Активна', 'Архив');

CREATE TABLE IF NOT EXISTS location (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS candidate (
    id SERIAL PRIMARY KEY,
	full_name TEXT NOT NULL,
	birthday DATE,
    location_id INTEGER REFERENCES location(id),
    ready_to_relocate BOOLEAN,
    phone VARCHAR(20),
    email VARCHAR(100)   
);

CREATE TABLE IF NOT EXISTS resume (
    id SERIAL PRIMARY KEY,
    candidate_id INTEGER REFERENCES candidate(id) NOT NULL,
	date_create DATE DEFAULT current_date,
	work_experience TEXT NOT NULL,
    expected_income INTEGER
);


CREATE TABLE IF NOT EXISTS employer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(300) NOT NULL,
   	description TEXT
);

CREATE TABLE IF NOT EXISTS vacancy (
    id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description TEXT NOT NULL,
    employer_id INTEGER REFERENCES employer(id) NOT NULL,
	location_id INTEGER REFERENCES location(id) NOT NULL,
	date_create DATE DEFAULT current_date,	
	status vacancy_status DEFAULT 'Активна',   
    compensation_from INTEGER,
    compensation_to INTEGER,
    compensation_gross BOOLEAN, -- true, если зарплата указана до вычета налогов, false, если после вычета налогов
    requirement TEXT	
);

CREATE TABLE IF NOT EXISTS response (
    id SERIAL PRIMARY KEY,
    vacancy_id INTEGER REFERENCES vacancy(id) NOT NULL,
    resume_id INTEGER REFERENCES resume(id) NOT NULL,
	date_create DATE DEFAULT current_date,
    status response_status DEFAULT 'Не просмотрен'
);

INSERT INTO employer (name, description)
VALUES ('Билайн', 'ПАО «ВымпелКом» (бренд Билайн) входит в группу компаний VEON Ltd.'),
		('Почта Банк', '«Почта Банк» – универсальный розничный банк, созданный группой ВТБ и Почтой России в 2016 году.'),
		('Сбер', 'Сбер — больше чем банк, это вселенная полезных сервисов для повседневной жизни человека.'),
		('Тинькофф', 'Тинькофф — финансовая экосистема для 10 млн клиентов'),
		('NAUMEN', 'ТОП-10 крупнейших разработчиков ПО по числу инсталляций в РФ (по версии TAdviser)'),
		('ООО Абак-Пресс', '«АБАК-ПРЕСС» был основан в 1992 году. Сегодня Медиапроекты АБАК-ПРЕСС — это динамично развивающиеся сетевые интернет- и печатные проекты. Уже 25 лет команда работает на будущее, ежедневно создавая новое, нужное, успешное. Всего только 25 лет мы учимся непрерывным изменениям, чтобы быть полезными нашим клиентам в решении завтрашних задач.'),
		('EPAM Systems, Inc.', 'ЕРАМ – международная IT-компания. Мы производим программное обеспечение – от начала и до конца. В нашей компании разрабатывают очень разные продукты: от онлайн-магазинов до VR игр для наших клиентов. Наши заказчики – международные финансовые, торговые, медицинские, медиа- и другие компании.'),
		('ХОСТ', 'Группа Компаний ХОСТ – федеральный системный интегратор, разработчик информационных систем. С 1993 года решаем задачи бизнеса с помощью высокотехнологичных проектов.'),
		('Сайтсофт', 'Компания «Сайтсофт» — является одним из признанных лидеров рынка в области разработки интернет решений для государственных организаций. Компания основана в 2005 году в Екатеринбурге. Четко определенные профессиональные принципы и хорошо продуманная стратегия развития позволили нашей компании быстро стать одним из лидеров в области разработки интернет-проектов в России.'),
		('СКБ Контур', 'СКБ Контур — федеральный разработчик интернет-сервисов, программного обеспечения для бизнеса и бухгалтерии.'),
		('skblab', 'СКБ ЛАБ - IT-проект, созданный для разработки новых финансовых сервисов.'),
		('ТОЧКА', 'Точка — первый в России мультибанковский сервис для предпринимателей. Мы запустились на базе филиала финансовой группы «Открытие» в декабре 2014 года. В 2017 — на базе международного банка «Qiwi».'),
		('ГБУЗ Свердловский областной онкологический диспансер', 'ГАУЗ СО "Свердловский областной онкологический диспансер" – это один из крупнейших в России онкологических диспансеров, со стационаром на 962 койки, с консультативно-диагностической поликлиникой свыше ста тысяч посещений в год,  является государственным учреждением.'),
		('Живика', 'Аптечная сеть "Живика" работает с 1998 года. За время своего развития предприятие стало одним из лидеров в Свердловской области, объединяя сегодня более 380 аптек по УрФО.  Аптечная сеть «Живика» – это сплочённая команда профессионалов.'),
		('Новая больница', 'Медицинское объединение  "Новая больница" создано в 1993 году на базе ГБ №33 г. Екатеринбурга. Имеет лицензию самого высокого, пятого уровня.'),
		('Сеть клиник лазерной косметологии и пластической хирургии ЛИНЛАЙН', 'ЛИНЛАЙН – крупнейшая в России сеть клиник лазерной косметологии и пластической хирургии. Первая клиника открылась в 1999 году, сейчас Сеть насчитывает 25 филиалов.'),
		('Кудри-Брови', 'Кудри, брови, ногти и все такое'),
		('Столовая N5', 'Общепит'),
		('Ветеринарный кабинет', 'Ветеринар круглосуточно'),
		('Музыкальная школа', 'Музыка'),
		('Художественная школа', 'художка');

INSERT INTO location (name)
VALUES ('Екатеринбург'),
		('Новосибирск'),
		('Тюмень'),
		('Краснодар'),
		('Калининград'),
		('Санкт-Петербург'),
		('Карпинск'),
		('Авокадо'),
		('Иркутск'),
		('Сочи');

INSERT INTO candidate (full_name, birthday, location_id, ready_to_relocate, phone, email)
VALUES ('Чаёк', make_date(1990, 01, 01), 2, null, '+79999999999', 'exaxa@coma.com'),
		('Лимончик', make_date(1956, 02, 20), 1, false, null, 'mamample@coma.com'),
		('Кипяток', make_date(1989, 03, 03), 9, false, '+79999999999', 'parample@coma.com'),
		('Царь', make_date(1992, 04, 04), 6, false, '+79999999999', null),
		('Царевич', make_date(1990, 05, 05), 4, false, '+79999999999', 'badample@coma.com'),
		('Король', null, 6, false, null, 'email'),
		('Королевич', make_date(1972, 07, 07), 7, true, '+79999999999', 'real@coma.com'),
		('Тест Тестович', make_date(1835, 08, 08), 7, false, '+79999999999', 'email@coma.com'),
		('Петрович', make_date(1990, 09, 09), 7, null, '+79999999999', 'for@coma.com'),
		('Трус', make_date(2014, 11, 11), 8, false, '+79999999999', null),
		('Бывалый', make_date(1990, 12, 12), 8, false, null, 'whilee@coma.com'),
		('Балбес', make_date(1999, 10, 10), 8, true, '+79999999999', 'except@coma.com');


INSERT INTO vacancy (name, description, employer_id, date_create, compensation_from, compensation_to, compensation_gross, location_id)
VALUES ('вакансия1', 'description1', 1, make_date(2020, 11, 01), 10000, 25000, true, 8),
		('вакансия2', 'description2', 1, make_date(2020, 11, 02), null, 50000, true, 8),
		('вакансия3', 'description3', 3, make_date(2020, 11, 02), null, 60000, true, 8),
		('вакансия4', 'description4', 3, make_date(2020, 11, 03), null, 79999, true, 7),
		('вакансия5', 'description5', 4, make_date(2020, 11, 03), 100000, 550000, false, 7),
		('вакансия6', 'description6', 4, make_date(2020, 11, 04), 120000, null, false, 7),
		('вакансия7', 'description7', 5, make_date(2020, 11, 05), 125035, null, false, 7),
		('вакансия8', 'description8', 5, make_date(2020, 11, 06), 140000, null, false, 9),
		('вакансия9', 'description9', 6, make_date(2020, 11, 07), 30000, null, false, 9),
		('вакансия10', 'description10', 6, make_date(2020, 11, 21), 85000, 95000, true, 1),
		('вакансия11', 'description11', 8, make_date(2020, 11, 11), 65000, 75000, true, 2),
		('вакансия12', 'description12', 8, make_date(2020, 11, 12), 55000, 65000, true, 3),
		('вакансия13', 'description13', 11, null, 12345, 23456, true, 4),
		('вакансия14', 'description14', 11, null, 14500, 28000, true, 5),
		('вакансия15', 'description15', 12, null, 540000, 550000, true, 6),
		('вакансия16', 'description16', 12, make_date(2020, 11, 13), null, null, null, 10),
		('вакансия17', 'description17', 12, make_date(2020, 12, 01), null, null, null, 9),
		('вакансия18', 'description18', 15, make_date(2020, 12, 02), null, null, null, 10),
		('вакансия19', 'description19', 18, make_date(2020, 12, 02), null, null, null,10);
		
insert into resume (candidate_id, date_create, work_experience, expected_income)
VALUES (1, make_date(2020, 01, 01), 'my work experience is none', 100000),
		(2, make_date(2020, 06, 01), 'my work experience is normal', 99000),
		(3, make_date(2020, 06, 01), 'my work experience is awesome', 88000),
		(1, null, 'Greate', null),
		(10, make_date(2020, 01, 10), 'my work experience is awesome', 88000),
		(11, make_date(2020, 01, 10), 'my work experience is normal', 99000),
		(12, make_date(2020, 01, 10), 'my work experience is none', 100000),
		(11, null, 'test', null),
		(6, make_date(2020, 03, 01), 'my work experience is awesome', 100000),
		(5, make_date(2020, 03, 01), 'my work experience is normal', 99000),
		(4, make_date(2020, 03, 01), 'my work experience is awesome', 88000);

INSERT INTO response (vacancy_id, resume_id, date_create)
VALUES (2, 10, make_date(2020, 12, 13)),
		(16, 4, make_date(2020, 12, 9)),
		(16, 8, make_date(2020, 12, 10)),
		(16, 10, make_date(2020, 12, 9)),
		(16, 1, make_date(2020, 12, 9)),
		(17, 4, make_date(2020, 12, 10)),
		(17, 8, make_date(2020, 12, 9)),
		(7, 6, make_date(2020, 12, 9)),
		(7, 7, make_date(2020, 12, 10)),
		(7, 10, make_date(2020, 12, 9)),
		(8, 6, make_date(2020, 12, 9)),
		(8, 2, make_date(2020, 12, 10)),
		(8, 3, make_date(2020, 12, 11)),
		(8, 11, make_date(2020, 12, 11)),
		(3, 7, make_date(2020, 12, 11)),
		(10, 1, make_date(2020, 12, 12)),
		(10, 2, make_date(2020, 12, 12)),
		(10, 3, make_date(2020, 12, 12)),
		(10, 4, make_date(2020, 12, 12)),
		(10, 5, make_date(2020, 12, 12));
