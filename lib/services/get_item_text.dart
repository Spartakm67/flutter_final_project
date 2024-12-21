class GetItemText {
 static String getItemText(int count) {
    if (count == 1) return "товар";
    if (count >= 2 && count <= 4) return "товари";
    return "товарів";
  }
}