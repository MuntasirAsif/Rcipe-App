class API
{
  static const hostConnect = "http://192.168.223.137/api_recipe";
  static const hostConnectUser = "$hostConnect/user";

  //Signup

  static const validateEmail = "$hostConnect/user/validate_user.php";
  static const signup = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";
  static const category = "$hostConnect/viewData/catagory.php";
  static const addCategory = "$hostConnect/viewData/add_category.php";
  static const recipe = "$hostConnect/viewData/recipe.php";
  static const instructions = "$hostConnect/viewData/instructions.php";
  static const addRecipe = "$hostConnect/viewData/add_recipe.php";
  static const addInstruction = "$hostConnect/viewData/add_instruction.php";
}