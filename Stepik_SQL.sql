1. Выборка новых столбцов и присвоение им новых имен
/*
Вывести всю информацию о книгах, а также для каждой позиции посчитать ее стоимость 
(произведение цены на количество) вычисляемому столбцу дать имя total 
*/

SELECT 
  title, 
  author, 
  price, 
  amount, 
  price * amount AS total 
FROM 
  book;

  /*Результат:
  +-----------------------+------------------+--------+--------+---------+
| title                 | author           | price  | amount | total   |
+-----------------------+------------------+--------+--------+---------+
| Мастер и Маргарита    | Булгаков М.А.    | 670.99 | 3      | 2012.97 |
| Белая гвардия         | Булгаков М.А.    | 540.50 | 5      | 2702.50 |
| Идиот                 | Достоевский Ф.М. | 460.00 | 10     | 4600.00 |
| Братья Карамазовы     | Достоевский Ф.М. | 799.01 | 2      | 1598.02 |
| Стихотворения и поэмы | Есенин С.А.      | 650.00 | 15     | 9750.00 |
+-----------------------+------------------+--------+--------+---------+
*/

  2.Выборка данных с созданием вычисляемого столбца
  /*
  Для упаковки каждой книги требуется один лист бумаги, цена которого 1 рубль 65 копеек.
  Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги)
  В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack
  */

  SELECT 
  title, 
  amount, 
  amount * 1.65 AS pack 
FROM 
  book;

  /*
  Результат:
  +-----------------------+--------+-------+
| title                 | amount | pack  |
+-----------------------+--------+-------+
| Мастер и Маргарита    | 3      | 4.95  |
| Белая гвардия         | 5      | 8.25  |
| Идиот                 | 10     | 16.50 |
| Братья Карамазовы     | 2      | 3.30  |
| Стихотворения и поэмы | 15     | 24.75 |
+-----------------------+--------+-------+
*/

3. Выборка данных, вычисляемые столбцы, математические функции
/*
В конце года цену всех книг на складе пересчитывают – снижают ее на 30%
Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг
Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.
*/

SELECT 
  title, 
  author, 
  amount,
  /*
  ROUND(x, k)

    округляет значение x до k знаков после запятой,
    если k не указано – x округляется до целого

    ROUND(4.361)=4
    ROUND(5.86592,1)=5.9
	 Столбец price умножаем на цену -30% = price*0.7 и округляем до 2 значений после запятой
 */
ROUND ((price * 0.7), 2)
AS new_price 
FROM book;

/*
Результат:

+-----------------------+------------------+--------+-----------+
| title                 | author           | amount | new_price |
+-----------------------+------------------+--------+-----------+
| Мастер и Маргарита    | Булгаков М.А.    | 3      | 469.69    |
| Белая гвардия         | Булгаков М.А.    | 5      | 378.35    |
| Идиот                 | Достоевский Ф.М. | 10     | 322.00    |
| Братья Карамазовы     | Достоевский Ф.М. | 2      | 559.31    |
| Стихотворения и поэмы | Есенин С.А.      | 15     | 455.00    |
+-----------------------+------------------+--------+-----------+
*/

4. Выборка данных, вычисляемые столбцы, логические функции
/*
При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова,
на втором месте книги Сергея Есенина.
Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%.
Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price.
Значение округлить до двух знаков после запятой.
   
	фамилию автора задавать с инициалами (как занесено в таблице), заключая в одинарные или двойные кавычки;
   для сравнения на равенство использовать знак =, например author = "Булгаков М.А.".
*/

SELECT author, title, 
ROUND (IF(author = 'Булгаков М.А.', price * 1.10, IF (author = 'Есенин С.А.', price * 1.05, price)), 2)
AS new_price
FROM book;

/* 
Результат:

+------------------+-----------------------+-----------+
| author           | title                 | new_price |
+------------------+-----------------------+-----------+
| Булгаков М.А.    | Мастер и Маргарита    | 738.09    |
| Булгаков М.А.    | Белая гвардия         | 594.55    |
| Достоевский Ф.М. | Идиот                 | 460.00    |
| Достоевский Ф.М. | Братья Карамазовы     | 799.01    |
| Есенин С.А.      | Стихотворения и поэмы | 682.50    |
+------------------+-----------------------+-----------+
*/

5. Выборка данных по условию
/*
Вывести автора, название  и цены тех книг, количество которых меньше 10.
*/

SELECT author, title, price
FROM book
WHERE amount <10; 

6. Выборка данных, логические операции
/*
Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600,
а стоимость всех экземпляров этих книг больше или равна 5000.
*/

SELECT title, author, price, amount 
FROM book 
WHERE (price <500 OR price >600) AND
price * amount >= 5000; 

/*
 Результат:

+-----------------------+-------------+--------+--------+
| title                 | author      | price  | amount |
+-----------------------+-------------+--------+--------+
| Стихотворения и поэмы | Есенин С.А. | 650.00 | 15     |
+-----------------------+-------------+--------+--------+
*/

7. Выборка данных, операторы BETWEEN, IN
/*
Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),
а количество или 2, или 3, или 5, или 7.
*/

SELECT title, author
FROM book
WHERE price BETWEEN 540.50 AND 800
AND (amount =2 or amount=3 or amount =5 or amount =7);

/*
Результат:

+--------------------+------------------+
| title              | author           |
+--------------------+------------------+
| Мастер и Маргарита | Булгаков М.А.    |
| Белая гвардия      | Булгаков М.А.    |
| Братья Карамазовы  | Достоевский Ф.М. |
+--------------------+------------------+
*/

8. 


