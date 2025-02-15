# 3D Market

## State Management 

- [Bloc](https://pub.dev/packages/flutter_bloc)
- [MobX](https://pub.dev/packages/mobx)
- [GetX](https://pub.dev/packages/get)
- [Riverpod](https://pub.dev/packages/riverpod)
- [Provider](https://pub.dev/packages/provider)

Primitive Type (int, String, double, boolean)

Error Handling

Id (Primary Key PK)
Foreign Key FK

projeye özgü widget'ları 'App' şeklinde
core yapıları ise 'Base' şeklinde adlandırabiliriz.

sen bir class oluşturduktan sonra onu kullanmak için class ismini yazıp constructor'ını çağırman yani parantez açıp kapaman gerekmekte 

class oluşturma: class ProfileService {...}
çağırma (instance oluşturma): ProfileService();


Value Equality (Değer Eşitliği)
her bir class'tan üretilen nesnenin (instance'ın) bir hashCode değeri vardır. Bu değer unique olduğu için compare işlemlerinde - karşılaştırma işlemlerinde nesnelerin her değeri birebir aynı olmasına rağmen aynı değildir. Equatable

Expanded
sadece layout widget'lar (Column, Row) içerisinde kullanılabilir. Kullanıldığı zaman widget'ın kaplayabildiği kadar alan kaplamasını sağlıyor

immutable mutable
değişmez  değişen


CRUD
Create
Read
Update
Delete