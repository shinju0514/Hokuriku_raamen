class User::SearchsController < ApplicationController

  def search
    @search = Post.ransack(params[:q])
    @results = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : @search.result
    # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
  end

  private
  
  def search_for(model, content, method)
    # 選択したモデルがpostだったら
    if model == 'post'
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect'
        Post.where(menu: content)
      # 選択した検索方法がが部分一致だったら
      elsif method == 'backward'
        Post.where('menu LIKE ?', '%'+content)
      elsif method == 'forward'
        Post.where('menu LIKE ?', content+'%')
      elsif method == 'partial'
        Post.where('menu LIKE ?', '%'+content+'%')
      end
    # 選択したモデルがshopだったら
    elsif model == 'shop'
     if method == 'perfect'
        Shop.where(shop_name: content)
     elsif method == 'backward'
        Shop.where('shop_name LIKE ?', '%'+content)
     elsif method == 'forward'
        Shop.where('shop_name LIKE ?', content+'%')
     elsif method == 'partial'
        Shop.where('shop_name LIKE ?', '%'+content+'%')
     end
    end
  end
end