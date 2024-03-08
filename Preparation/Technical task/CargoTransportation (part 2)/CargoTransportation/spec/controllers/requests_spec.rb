# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::RequestsController, type: :controller do
  render_views
  let(:request_test) { FactoryBot.create(:request) }
  let(:another_request_test) { FactoryBot.create(:request) }
  let(:valid_attributes_1) do
    {
      name: 'Антон',
      surname: 'Антонов',
      patronymic: 'Антонович',
      email: 'anton@anton.com',
      phone_number: 88_005_553_535,
      weight: 11,
      length: 120,
      width: 200,
      height: 300,
      point_of_departure: 'Россия',
      destination: 'Китай'
    }
  end

  let(:valid_attributes_2) do
    {
      name: 'Антон',
      surname: 'Антонов',
      patronymic: 'Антонович',
      email: 'anton@anton.com',
      phone_number: 88_005_553_535,
      weight: 10,
      length: 120,
      width: 200,
      height: 300,
      point_of_departure: 'Россия',
      destination: 'Китай'
    }
  end

  let(:valid_attributes_3) do
    {
      name: 'Антон',
      surname: 'Антонов',
      patronymic: 'Антонович',
      email: 'anton@anton.com',
      phone_number: 88_005_553_535,
      weight: 9,
      length: 20,
      width: 30,
      height: 10,
      point_of_departure: 'Россия',
      destination: 'Китай'
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      surname: '',
      patronymic: '',
      email: '',
      phone_number: '',
      weight: '',
      length: '',
      width: '',
      height: '',
      point_of_departure: '',
      destination: ''
    }
  end

  describe 'GET index' do
    context 'Пользователь переходит на стринцу со всеми заявками' do
      before do
        get :index
      end

      it 'Запрос успешный' do
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'Создание нового маршрута с неправильными атрибутами' do
      it 'Создание нового маршрута с неправильными атрибутами' do
        expect do
          post :create, params: { request: invalid_attributes }
        end.not_to change(Request, :count)
      end
    end

    context 'Создание нового маршрута с правильными атрибутами' do
      it 'Запрос пройдёт успешное добавление записи в базу данных' do
        expect do
          post :create, params: { request: valid_attributes_1 }
        end.to change(Request, :count).by(1)
      end

      it 'Случай при объёме > 1 и весе > 10' do
        post :create, params: { request: valid_attributes_1 }
        expect(Request.last.price).to eq(Request.last.distance * 3)
      end

      it 'Случай при объёме > 1 и весе <= 10' do
        post :create, params: { request: valid_attributes_2 }
        expect(Request.last.price).to eq(Request.last.distance * 2)
      end

      it 'Случай при объёме < 1' do
        post :create, params: { request: valid_attributes_3 }
        expect(Request.last.price).to eq(Request.last.distance)
      end

      it 'Перенаправление на страницу заявки после её создания с правильными выходными данными' do
        post :create, params: { request: valid_attributes_1 }
        expect(response).to redirect_to admin_request_path(Request.last.id)
      end
    end
  end
end
