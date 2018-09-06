//
//  StartupCommandsBuilder.swift
//  Ligu_Swift
//
//  Created by locklight on 2018/9/6.
//  Copyright © 2018年 LockLight. All rights reserved.
//

import UIKit

final class StartupCommandsBuilder{
	private var window:UIWindow!
	
	func setKeyWindow(_ window:UIWindow) -> StartupCommandsBuilder{
		self.window = window
		return self
	}
	
	func build() -> [Command]{
		return [initialViewControllerCommand(keyWindow: window),
				initialAppearanceCommand(),
				initialThirdPartiesCommand(),
				registerToRemoteNotificationCommand()]
	}
}

protocol Command {
	func execute()
}

struct initialViewControllerCommand:Command {
	let keyWindow:UIWindow
	
	func execute() {
		//Pick root vc
		keyWindow.rootViewController = LGTabbarController()
	}
}

struct initialThirdPartiesCommand:Command {
	func execute() {
		//ThirdParties initial here
	}
}

struct initialAppearanceCommand:Command{
	func execute() {
		//Set UIAppearance
	}
}

struct registerToRemoteNotificationCommand:Command {
	func execute() {
		//Register for remote notification
	}
}



