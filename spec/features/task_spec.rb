require 'rails_helper'

RSpec.describe Task, type: :feature do
  describe 'visit the index of tasks' do
    before do
      create_list(:task, 3)
    end

    it "checks tasks can be showed on index page"do
      visit tasks_path

      expect(page).to have_css(
                                'table tbody tr:first-child td:first-child', 
                                text: "#{Task.first.title}"
                              )
      expect(page).to have_css(
                                'table tbody tr:first-child td:nth-child(2)', 
                                text: "#{Task.first.description}"
                              )

      expect(page).to have_css(
                                'table tbody tr:nth-child(2) td:first-child', 
                                text: "#{Task.second.title}"
                              )
      expect(page).to have_css(
                                'table tbody tr:nth-child(2) td:nth-child(2)', 
                                text: "#{Task.second.description}"
                              )

      expect(page).to have_css(
                                'table tbody tr:nth-child(3) td:first-child', 
                                text: "#{Task.third.title}"
                              )
      expect(page).to have_css(
                                'table tbody tr:nth-child(3) td:nth-child(2)', 
                                text: "#{Task.third.description}"
                              )
    end
  end

  describe 'create a task' do
    let(:title) { Faker::Lorem.sentence }
    let(:description) { Faker::Lorem.paragraph }
    
    it 'with title and description' do
      create_task_with("#new_task", title, description)
      expect(Task.all.size).to be 1
      expect(page).to have_content("#{I18n.t('tasks.create.notice')}")
      expect(page).to have_content(title)
      expect(page).to have_content(description)
    end

    it 'without title and description' do
      create_task_with("#new_task", nil, nil)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.description')} #{I18n.t('activerecord.errors.models.task.attributes.description.blank')}")
    end

    it 'without title' do
      create_task_with("#new_task", nil, description)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
    end

    it 'without description' do
      create_task_with(".new_task", title, nil)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.description')} #{I18n.t('activerecord.errors.models.task.attributes.description.blank')}")
    end
  end

  describe 'view a task' do
    let(:task){ create(:task) }

    it do
      visit task_path(task)

      expect(page).to have_content(task.title)
      expect(page).to have_content(task.description)
    end
  end

  describe 'edit a task' do
    let(:task){ create(:task) }
    let(:new_title) { Faker::Lorem.sentence }
    let(:new_description) { Faker::Lorem.paragraph }

    before :each do
      visit edit_task_path(task)
    end

    it 'with new title and new description' do
      edit_task_with(".edit_task", new_title, new_description)
      expect(page).to have_content("#{I18n.t('tasks.update.notice')}")
      expect(page).to have_content(new_title)
      expect(page).to have_content(new_description)
    end

    it 'without title and new description' do
      edit_task_with(".edit_task")
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.description')} #{I18n.t('activerecord.errors.models.task.attributes.description.blank')}")    
    end

    it 'without title' do
      edit_task_with(".edit_task", nil, new_description)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
    end

    it 'without description' do
      edit_task_with(".edit_task", new_title)
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.description')} #{I18n.t('activerecord.errors.models.task.attributes.description.blank')}")    
    end
  end

  describe 'delete a task' do
    it do
      create(:task)
      visit tasks_path

      click_on "#{I18n.t('link.delete')}"
      expect(page).to have_content("#{I18n.t('tasks.destroy.notice')}")
      expect(Task.all.size).to be 0
    end
  end

  describe 'order' do
    before do
      @tasks = []
      3.times do
        task = create(:task)
        @tasks << task
      end
      visit tasks_path
    end

    it 'by created time asc' do
      click_on I18n.t("order.created_asc")
      within('table') do
        expect(page).to have_content(
          /#{@tasks[0][:title]}+#{@tasks[1][:title]}+#{@tasks[2][:title]}/
        )
      end
    end

    it 'by created time desc' do
      click_on I18n.t("order.created_desc")
      within('table') do
        expect(page).to have_content(
          /#{@tasks[2][:title]}+#{@tasks[1][:title]}+#{@tasks[0][:title]}/
        )
      end
    end
  end

  private
  def create_task_with(form, title, description)
    visit new_task_path
    within(form) do
      fill_in "#{I18n.t('tasks.table.title')}", with: title
      fill_in "#{I18n.t('tasks.table.description')}", with: description
      fill_in "#{I18n.t('tasks.table.start_time')}", with: Time.now
      fill_in "#{I18n.t('tasks.table.end_time')}", with: Faker::Time.forward
      find('input[name="commit"]').click
    end
  end

  def edit_task_with(form, new_title = nil, new_description = nil)
    within(form) do
      fill_in "#{I18n.t('tasks.table.title')}", with: new_title
      fill_in "#{I18n.t('tasks.table.description')}", with: new_description
      find('input[name="commit"]').click
    end
  end
end 