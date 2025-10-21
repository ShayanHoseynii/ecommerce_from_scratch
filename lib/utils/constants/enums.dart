/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */

enum AppRole { admin, user }

enum Role { admin, manager, operator, fleetOwner, fleetManager, fleetOperator, driver, user, unknown }

enum ChatType { support }

enum ChatMessageStatus { sending, sent, delivered, read, failed }

enum VerificationStatus { unknown, pending, submitted, underReview, approved, rejected }

enum TextSizes { small, medium, large }

enum ProductType {single, variable}

enum OrderStatus { pending, processing, completed, cancelled, refunded, failed, onHold, unknown }
enum PaymentMethod { creditCard, paypal, bankTransfer, cashOnDelivery, unknown }
