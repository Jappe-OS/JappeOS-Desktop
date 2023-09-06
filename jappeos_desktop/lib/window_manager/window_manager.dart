//  JappeOS-Desktop, The desktop environment for JappeOS.
//  Copyright (C) 2023  Jappe02
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Affero General Public License as
//  published by the Free Software Foundation, either version 3 of the
//  License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Affero General Public License for more details.
//
//  You should have received a copy of the GNU Affero General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

library window_manager;

import 'dart:async';
import 'dart:math';

import 'package:event/event.dart';
import 'package:flutter/material.dart';
import 'package:jappeos_desktop/main.dart';
import 'package:jappeos_desktop_ui/widgets/blur_container.dart';
import 'package:jappeos_desktop_ui/widgets/solid_container.dart';
import 'package:jappeos_desktop_ui/widgets/text.dart';

import '../base/base.dart';

//
// Window types
part 'window_types/wm_window_general.dart';
part 'window_types/dialog_window.dart';
part 'window_types/normal_window.dart';
part 'window_types/custom_window.dart';
//
// Window manager base
part 'wm_controller.dart';
part 'wm_manager.dart';
part 'wm_window.dart';