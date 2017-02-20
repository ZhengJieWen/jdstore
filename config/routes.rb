Rails.application.routes.draw do
    root 'welcome#index'
    devise_for :users

    namespace :admin do
        resources :products
        resources :orders do
        end
    end

    resources :products do
        member do
            post :add_to_cart
        end
    end

    resources :carts do
        collection do
            delete :clean
            post :checkout
        end
    end

    namespace :account do
        resources :orders
    end

    resources :cart_items
    resources :carts
end
