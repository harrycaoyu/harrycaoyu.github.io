var tag = document.createElement('script');
tag.src = "http://www.youtube.com/player_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

//  This function creates an <iframe> (and YouTube player)
//  after the API code downloads.
var player;
function onYouTubePlayerAPIReady() {
player = new YT.Player('mattamy-ytplayer', {
  playerVars: { 'autoplay':1,'controls':0,'wmode':'opaque','loop':1,'playlist':'jYZstC2PlLY','origin':'http://flybrizi/com' },
  videoId: 'jYZstC2PlLY',
  events: {
    'onReady': onPlayerReady}
});
}

// The API will call this function when the video player is ready.
function onPlayerReady(event) {
event.target.mute();
}