//
//  ImagePicker.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 13.09.2022.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment (\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary //откуда брать фото либо из галерии либо из камеры
    @Binding var selectedImage: UIImage //та картинка которая будет подтягиваться из пикера будет помещаться в это свойство
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        } //этот метод вшит в UIImagePickerControllerDelegate и будет отвечать за перемещение картинки отсюда в selectedImage
    }
}
