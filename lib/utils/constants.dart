import 'package:alekhlas_teachers/screens/system_users/model/system_user_model.dart';

const String Gmail = 'Gmail';
const String Facebook = 'Facebook';
var currentLoginPassword = "";
SystemUserModel currentLoggedInUserData = SystemUserModel.initial();

const String INDIVIDUAL = "individual";
const String COMPANY = "company";

const String SUPER_ADMIN = "super_admin";
const String DASHBOARD = "dashboard";

const String ADS_VIEW = "ads_view";
const String ADS_ADD = "ads_add";
const String ADS_DELETE = "ads_delete";
const String ADS_UPDATE = "ads_update";

const String NOTIFICATIONS_VIEW = "notifications_view";
const String NOTIFICATIONS_ADD = "notifications_add";
const String NOTIFICATIONS_DELETE = "notifications_delete";
const String NOTIFICATIONS_UPDATE = "notifications_update";

const String CATEGORY_VIEW = "category_view";
const String CATEGORY_ADD = "category_add";
const String CATEGORY_DELETE = "category_delete";
const String CATEGORY_UPDATE = "category_update";

const String SUB_CATEGORY_VIEW = "sub_category_view";
const String SUB_CATEGORY_ADD = "sub_category_add";
const String SUB_CATEGORY_UPDATE = "sub_category_update";
const String SUB_CATEGORY_DELETE = "sub_category_delete";

const String PROMOCODE_VIEW = "promocode_view";
const String PROMOCODE_ADD = "promocode_add";
const String PROMOCODE_UPDATE = "promocode_update";
const String PROMOCODE_DELETE = "promocode_delete";

const String SYSTEM_USERS_VIEW = "system_users_view";
const String SYSTEM_USERS_ADD = "system_users_add";
const String SYSTEM_USERS_UPDATE = "system_users_update";
const String SYSTEM_USERS_DELETE = "system_users_delete";

const String WORKERS_VIEW = "workers_view";
const String WORKERS_ADD = "workers_add";
const String WORKERS_UPDATE = "workers_update";
const String WORKERS_DELETE = "workers_delete";

const String CUSTOMERS_VIEW = "customers_view";
const String CUSTOMERS_UPDATE = "customers_update";

const String SUPPORT_MESSAGES_VIEW = "support_messages_view";
const String SUPPORT_MESSAGES_ADD = "support_messages_add";

const String CANCEL_MESSAGE_VIEW = "cancel_message_view";

const String SERVICES_VIEW = "services_view";
const String SERVICES_ADD = "services_add";
const String SERVICES_UPDATE = "services_update";
const String SERVICES_DELETE = "services_delete";

const String ORDERS_VIEW = "orders_view";
const String ORDERS_UPDATE = "orders_update";
const String ORDERS_DETAILS = "orders_details";




List<String> roles = [
  DASHBOARD,
  ADS_ADD,
  ADS_VIEW,
  ADS_DELETE,
  ADS_UPDATE,
  NOTIFICATIONS_ADD,
  NOTIFICATIONS_DELETE,
  NOTIFICATIONS_UPDATE,
  NOTIFICATIONS_VIEW,
  CATEGORY_ADD,
  CATEGORY_VIEW,
  CATEGORY_DELETE,
  CATEGORY_UPDATE,
  SUB_CATEGORY_ADD,
  SUB_CATEGORY_VIEW,
  SUB_CATEGORY_UPDATE,
  SUB_CATEGORY_DELETE,
  SERVICES_ADD,
  SERVICES_VIEW,
  SERVICES_UPDATE,
  SERVICES_DELETE,
  ORDERS_VIEW,
  ORDERS_UPDATE,
  ORDERS_DETAILS,
  PROMOCODE_VIEW,
  PROMOCODE_ADD,
  PROMOCODE_UPDATE,
  PROMOCODE_DELETE,
  SYSTEM_USERS_VIEW,
  SYSTEM_USERS_ADD,
  SYSTEM_USERS_UPDATE,
  SYSTEM_USERS_DELETE,
  WORKERS_VIEW,
  WORKERS_ADD,
  WORKERS_UPDATE,
  WORKERS_DELETE,
  CUSTOMERS_VIEW,
  CUSTOMERS_UPDATE,
  SUPPORT_MESSAGES_VIEW,
  SUPPORT_MESSAGES_ADD,
];

bool hasThisPermission(String permission) {
  try {
    if (currentLoggedInUserData.is_super_admin!) return true;
    return (currentLoggedInUserData.roles!.contains(permission)) ? true : false;
  } catch (e) {
    return false;
  }
}
