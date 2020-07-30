document.addEventListener('turbolinks:load', function () {
  if (!$('#item_form')[0]) return false; //商品出品・編集ページではないなら以降実行しない。

  // 画像の編集ボタンをクリックした時
  $("#selected-item-images").on("click", ".item-image__buttons--edit", function (e) {
    const index = $(this).parents(".item-image").data("index");
    $(`#item_images_attributes_${index}_src`).trigger("click");
  });

  // 画像の削除ボタンをクリックした時
  $("#selected-item-images").on("click", ".item-image__buttons--delete", function (e) {
    const index = $(this).parents(".item-image").data("index");
    $(this).parents(".item-image").remove();
    $(`#item_images_attributes_${index}__destroy`).prop("checked", true);
    $(`#item_images_attributes_${index}_src`).remove();
  });

  //新規画像投稿用のfile_fieldを作成しappendする。
  function newFileField(index) { 
    const html = `
               <input accept="image/*" class="new-item-image" data-index="${index}" type="file" name="item[images_attributes][${index}][src]" id="item_images_attributes_${index}_src">
               `;
    return html;
  }

  //選択した画像ファイルのプレビューを表示する。
  function buildImagePreview(blob_url, index) { 
    html = `
            <div class="item-image new" data-index=${index}>
              <img src =${blob_url} class="item-image__image">
              <div class="item-image__buttons">
                <div class="item-image__buttons--edit">
                編集
                </div>
                <div class="item-image__buttons--delete">
                削除
                </div>
              </div>
            </div>
            `;
    return html;
  }

  $("#select-image-button").on("click", function () {
    const file_field = $(".new-item-image:last"); // 新規画像投稿用のfile_fieldを取得する。
    file_field.trigger("click"); // file_fieldをクリックさせる。
  });

  // file_fieldが変化した時
  $("#image-file-fields").on("change", `input[type="file"]`, function (e) { //新しく画像が選択された、もしくは変更しようとしたが何も選択しなかった時
    const file = e.target.files[0];
    let index = $(this).data("index");

    if (!file) {
      const delete_button = $(`.item-image[data-index="${index}"]`).find(".item-image__buttons--delete");
      delete_button.trigger("click");
      return false;
    }

    const blob_url = window.URL.createObjectURL(file); //選択された画像をblob url形式に変換する。

    if ($(`.item-image[data-index="${index}"]`)[0]) {
      const preview_image = $(`.item-image[data-index="${index}"]`).children("img");
      preview_image.attr("src", blob_url);
      return false;
    }

    const preview_html = buildImagePreview(blob_url, index);
    $("#select-image-button").before(preview_html);

    index += 1;
    const file_field_html = newFileField(index);
    $("#image-file-fields").append(file_field_html);
  });

});