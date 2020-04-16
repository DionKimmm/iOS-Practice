//
//  GithubViewController.swift
//  UITest
//
//  Created by 김동욱 on 15/04/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class GithubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
// extension을 이용한 Protocol 선언 방법
// 해당되는 프로토콜을 나누어 선언 하는 것이 요즘의 관례임.

extension GithubViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 1, height: UIScreen.main.bounds.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
}

extension GithubViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        
        return cell
    }
    
    
}

extension GithubViewController: UICollectionViewDelegate {
    
}
