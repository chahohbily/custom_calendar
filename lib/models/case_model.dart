class Order {
  final String id;
  final String clientName;
  final String masterName;
  final String masterAvatar;
  final String serviceName;
  DateTime date;

  Order(this.id, this.clientName, this.masterName, this.masterAvatar, this.serviceName, this.date);
}