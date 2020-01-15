//
//  EvilSprite.h
//  EvilCard
//
//  Created by keltonxian on 7/29/14.
//
//

#ifndef __EvilCard__EvilSprite__
#define __EvilCard__EvilSprite__

#include "cocos2d.h"

USING_NS_CC;

class EvilSprite : public Sprite {
public:
    static EvilSprite* create(const std::string& filename);
    void shake(float duration, float radius, float delay);
private:
    void updateShake(float delta);
    EvilSprite(void);
    virtual ~EvilSprite(void);
    virtual void draw(Renderer *renderer, const Mat4 &transform, uint32_t flags) override;
    
    int shake_times;
    float shake_radius;
    float originX;
    float originY;
};

#endif /* defined(__EvilCard__EvilSprite__) */
