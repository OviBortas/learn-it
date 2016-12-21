//
//  Draggable.swift
//  LearnIt
//
//  Created by Ovidiu Bortas on 12/20/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import Foundation

protocol Draggable: class {
    func didSnap(label: DraggableLabel, to position: Position)
    func willSnap(label: DraggableLabel, to position: Position)
}
