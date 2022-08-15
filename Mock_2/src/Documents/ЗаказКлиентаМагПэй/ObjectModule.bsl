
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		ЗаполнитьДокументНаОснованииПолученныхДанных(ДанныеЗаполнения);
	КонецЕсли;

КонецПроцедуры

Процедура ЗаполнитьДокументНаОснованииПолученныхДанных(ДанныеЗаполнения)
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
	ЭтотОбъект.Дата = ТекущаяДатаСеанса();
	ЭтотОбъект.external_id = СтрШаблон("%1%2", "a", ЭтотОбъект.external_id);
	ЭтотОбъект.id = Новый УникальныйИдентификатор();
	
	Если Не Метаданные.Перечисления.СпособыОплатыМагПэй.ЗначенияПеречисления.Найти(ДанныеЗаполнения.payment_type) = Неопределено Тогда
		ЭтотОбъект.payment_type = Перечисления.СпособыОплатыМагПэй[ДанныеЗаполнения.payment_type];
	КонецЕсли;
	
	Для Каждого Товар Из ДанныеЗаполнения.items Цикл
		
		НоваяСтрока = ЭтотОбъект.items.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Товар);
		Если Не Метаданные.Перечисления.ТипыНалоговМагПэй.ЗначенияПеречисления.Найти(Товар.tax) = Неопределено Тогда
			НоваяСтрока.tax = Перечисления.ТипыНалоговМагПэй[Товар.tax];
		КонецЕсли;
		
	КонецЦикла;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения.client);
	
КонецПроцедуры