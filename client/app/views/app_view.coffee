View      = require '../lib/view'
AppRouter = require '../routers/app_router'
BookmarksView = require './bookmarks_view'

module.exports = class AppView extends View
    el: 'body.application'

    template: ->
        require './templates/home'

    initialize: ->
        @router = CozyApp.Routers.AppRouter = new AppRouter()
        
    afterRender: ->
        @bookmarksView = new BookmarksView()
        
        
        @bookmarksView.$el.html '<em>loading ...</em>'
        
        @bookmarksView.collection.fetch
            success: => @bookmarksView.$el.find('em').remove()
            
            
Bookmark = require '../models/bookmark_model'

events:
    'click .create-button': 'onCreateClicked'
    
onCreateClicked: =>
    title = $('.title-field').val()
    url = $('.url-field').val()
    
    if title?.length > 0 and url?.length > 0
        bookmark = new Bookmark
        title: title
        url: url
        
        @bookmarksView.collection.create bookmark,
            success: => alert "bookmark added"
            error: => alert "Server error occured, bookmark was not saved"
        
    else
        alert 'Both fields are required'
