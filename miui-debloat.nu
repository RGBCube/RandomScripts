#!/usr/bin/env nu

const ids = [
  com.amazon.appmanager
  com.android.bips
  com.android.bookmarkprovider
  com.android.browser
  com.android.browser
  com.android.cellbroadcastreceiver
  com.android.chrome
  com.android.chrome
  com.android.email
  com.android.email
  com.android.midrive
  com.android.printservice.recommendation
  com.android.printspooler
  com.android.quicksearchbox
  com.android.wallpaper.livepicker
  com.caf.fmradio
  com.duokan.phone.remotecontroller
  com.facebook.appmanager
  com.facebook.appmanager
  com.facebook.services
  com.facebook.services
  com.facebook.system
  com.facebook.system
  com.facemoji.lite.xiaomi
  com.google.android.apps.cloudprint
  com.google.android.apps.docs
  com.google.android.apps.maps
  com.google.android.apps.photos
  com.google.android.apps.photos
  com.google.android.apps.safetyhub
  com.google.android.apps.subscriptions.red
  com.google.android.apps.tachyon
  com.google.android.apps.tachyon
  com.google.android.apps.wearables.maestro.companion
  com.google.android.feedback
  com.google.android.gm
  com.google.android.googlequicksearchbox
  com.google.android.googlequicksearchbox
  com.google.android.markup
  com.google.android.marvin.talkback
  com.google.android.marvin.talkback
  com.google.android.music
  com.google.android.music
  com.google.android.projection.gearhead
  com.google.android.syncadapters.calendar
  com.google.android.syncadapters.contacts
  com.google.android.talk
  com.google.android.talk
  com.google.android.tts
  com.google.android.tts
  com.google.android.videos
  com.google.android.videos
  com.google.android.wearable.assistant
  com.google.android.youtube
  com.google.ar.lens
  com.google.audio.hearing.visualization.accessibility.scribe
  com.mfashiongallery.emag
  com.mfashiongallery.emag
  com.mi.android.globalpersonalassistant
  com.mi.android.globalpersonalassistant
  com.mi.dlabs.vr
  com.mi.global.bbs
  com.mi.global.shop
  com.mi.globalTrendNews
  com.mi.webkit.core
  com.mi.webkit.core
  com.micredit.in
  com.milink.service
  com.milink.service
  com.mipay.wallet.id
  com.mipay.wallet.in
  com.miui.analytics
  com.miui.analytics
  com.miui.android.fashiongallery
  com.miui.antispam
  com.miui.bugreport
  com.miui.bugreport
  com.miui.cleanmaster
  com.miui.cloudbackup
  com.miui.cloudbackup
  com.miui.cloudservice
  com.miui.cloudservice
  com.miui.cloudservice.sysbase
  com.miui.cloudservice.sysbase
  com.miui.compass
  com.miui.contentcatcher
  com.miui.gallery
  com.miui.greenguard
  com.miui.hybrid
  com.miui.hybrid
  com.miui.hybrid.accessory
  com.miui.hybrid.accessory
  com.miui.klo.bugreport
  com.miui.klo.bugreport
  com.miui.micloudsync
  com.miui.micloudsync
  com.miui.miservice
  com.miui.miservice
  com.miui.mishare.connectivity
  com.miui.msa.global
  com.miui.notes
  com.miui.personalassistant
  com.miui.player
  com.miui.player
  com.miui.providers.weather
  com.miui.providers.weather
  com.miui.screenrecorder
  com.miui.screenrecorder
  com.miui.touchassistant
  com.miui.touchassistant
  com.miui.translation.kingsoft
  com.miui.translation.xmcloud
  com.miui.translation.youdao
  com.miui.translationservice
  com.miui.userguide
  com.miui.videoplayer
  com.miui.videoplayer
  com.miui.virtualsim
  com.miui.virtualsim
  com.miui.weather2
  com.miui.weather2
  com.miui.yellowpage
  com.miui.yellowpage
  com.netflix.partner.activation
  com.swiftkey.languageprovider
  com.swiftkey.swiftkeyconfigurator
  com.xiaomi.account
  com.xiaomi.account
  com.xiaomi.discover
  com.xiaomi.finddevice
  com.xiaomi.glgm
  com.xiaomi.joyose
  com.xiaomi.location.fused
  com.xiaomi.mi_connect_service
  com.xiaomi.micloud.sdk
  com.xiaomi.midrop
  com.xiaomi.midrop
  com.xiaomi.mipicks
  com.xiaomi.mipicks
  com.xiaomi.miplay_client
  com.xiaomi.miplay_client
  com.xiaomi.mirecycle
  com.xiaomi.mirecycle
  com.xiaomi.oversea.ecom
  com.xiaomi.payment
  com.xiaomi.payment
  com.xiaomi.providers.appindex
  com.xiaomi.scanner
  com.xiaomi.xmsf
]

print "waiting for adb device..."
adb wait-for-device

for id in $ids {
  print --no-newline $"trying to uninstall ($id)... "

  try { adb shell pm uninstall --user 0 $id o+e>| print $in }
}
