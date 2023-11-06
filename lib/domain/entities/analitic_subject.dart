enum AnaLiticSubject {
  byServices('Сервисы'),
  bySumPeriod('Общая сумма за год'),
  byActionCategory('Категория оплаты');

  const AnaLiticSubject(this.actionName);
  final String actionName;
}