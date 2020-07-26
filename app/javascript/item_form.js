document.addEventListener('turbolinks:load', function () {
  if (!$('#item_form')[0]) return false; //商品出品・編集ページではないなら以降実行しない。

  $("#select-image-button").on("click", function () {
    const file_field = $("#item_images_attributes_0_src"); // 新規画像投稿用のfile_fieldを取得する。
    file_field.trigger("click"); // file_fieldをクリックさせる。
  });

  $("#image-file-fields").on("change", `input[type="file"]`, function () { //新しく画像が選択された、もしくは変更しようとしたが何も選択しなかった時
    console.log("画像が選択されました")
  });

});